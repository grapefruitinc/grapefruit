// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

function html_escape(str) {
    return String(str)
            .replace(/&/g, '&amp;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;');
}

$("document").ready(function(){

  $(document).foundation();

  var flash = $("div#top-flash div.alert-box");

  var current_flash_color = flash.css("backgroundColor");
  var highlight_flash_color = flash.parent().css("backgroundColor");

  flash.stop().delay(280)
    .animate({ backgroundColor: highlight_flash_color }, 200)
    .animate({ backgroundColor: current_flash_color }, 300);


  /* forms */

  if($("#lecture-comments").length){

    var refresh_comments = function(){
      var lecture_id = $("#lecture-comments").data("lecture-id");
      var list_url = $("#lecture-comments").data("url");
      $.ajax({
        type: "GET",
        url: list_url,
        data: {lecture: lecture_id}
      }).done(function(comments) {
        $("#lecture-comments").html("");
        $.each(comments, function() {
          var comment = "<p>";
          comment += "<strong>" + this.author.display_identifier + "</strong>: ";
          comment += Autolinker.link(html_escape(this.body));
          comment += "&nbsp;&nbsp;<span class='comment-date'>" + this.relative_time + " ago </span> ";
          comment += "</p>";
          $("#lecture-comments").append(comment);
        });
        if(comments.length == 0){
          $("#lecture-comments").append("<p class='empty'>No comments yet! Be the first.</p>")
        }
      }).fail(function(error, as){
        
      });
      setTimeout(refresh_comments, 5000);
    };

    refresh_comments();

    $("#comments-submit").on("ajax:success", function(){
      $("#comment-body").val("").select();
      refresh_comments();
    });


    $("#lecture-comments").on("mouseover", "p", function(){
      $(this).children("span.comment-date").show();
    }).on("mouseout", "p", function(){
      $(this).children("span.comment-date").hide();
    });

  }

  if(typeof home_standalone == 'undefined'){

    var sidebar = {
      init: function(a){
        $this = a;
        capsule = $this.find(".course-capsule");
        type = $this.find(".capsule-nav li");
        originalHeight = capsule.css("height");
        marginBump = $this.find(".capsule-header").outerHeight();
      },
      type: function(){
        return $this.find(".capsule-nav li");
      },
      self: function(){
        console.log($this);
      },
      capsule: function(){
        return capsule;
      },
      updateCoords: function() {
        active_capsule = $this.children(".course-capsule.active").index();
        active_type = $this.children(".course-capsule.active").children("nav li.active").index();
        active_item = $this.children(".course-capsule.active").children(".capsule-item.active").index();
      },
      get: function(capsule, type, item){
        if(capsule >= $this.children(".course-capsule").length || type > 2){return false;}
        type = typeof type !== 'undefined' ? type : 0;
        item = typeof item !== 'undefined' ? item : 0;

        return $this.children(".course-capsule").eq(capsule)
              .children(".capsule-contents").eq(type)
              .children(".capsule-item").eq(item);
      },
      navigateToCapsule: function(capsule){
        if(capsule == -1){return false;}

        $capsule = $this.children(".course-capsule[data-capsule-id=" + capsule + "]");

        if(!$capsule.hasClass("active")){
          $capsule.siblings().removeClass("active").animate({height: originalHeight}, 250);
          $capsule.addClass("active").animate({
            height: $capsule.children("ul.capsule-contents.active").outerHeight()+(marginBump)
          }, 250, function(){
          });
        }
        return this;
      },
      navigateToType: function(type){
        if(type > 2 || type == -1){return false;}
        $listing = $capsule.find(".capsule-contents").removeClass("active").eq(type);
        $listing.addClass("active").css("height", $listing.parent().outerHeight()-marginBump);
        $capsule.children(".capsule-contents").first().animate({
          marginLeft: ((-100*type) +"%")
        }, 250, function(){
        });
        $type = $listing.parent().find(".capsule-nav li").removeClass("active").eq(type);
        $type.addClass("active");
        return this;
      },
      navigateToItem: function(item){
        var active_item = $this.find(".course-capsule.active .capsule-contents.active");
        active_item.children().removeClass("active");
        active_item.find("li[data-lecture-id=" + item + "]").addClass("active");
        return this;
      },
      navigate: function(c, p, i){
        this.navigateToCapsule(c).navigateToType(p).navigateToItem(i);
      }
    }

    $(window).resize(function() {
      if($(".mobile-nav").css("display")!="none"){
        var medium = true;
        var small = true;
      }
      if(small || medium){
        sidebar.init($(".course-accordion--mobile"));
      } else {
        sidebar.init($(".course-accordion"));      
      }
    });

    if($(".mobile-nav").css("display")!="none"){
      var medium = true;
      var small = true;
    }

    var current_capsule = (typeof capsule_id == 'undefined') ? -1 : capsule_id;
    var current_lecture = (typeof lecture_id == 'undefined') ? -1 : lecture_id;
    var current_type = 0;

    if($(".course-accordion").height){ // just in case the accordion isn't there

      if(small || medium){
        sidebar.init($(".course-accordion--mobile"));
        sidebar.navigate(current_capsule, current_type, current_lecture);
        sidebar.type().click(function(e){
          e.preventDefault();
          sidebar.navigateToType(e.target.eq());
        });

      } else {
        sidebar.init($(".course-accordion"));
        sidebar.navigate(current_capsule, current_type, current_lecture);
        sidebar.type().click(function(e){
          e.preventDefault();
          sidebar.navigateToType($(e.target).parent().index());
        });
      }

    }

  }

});