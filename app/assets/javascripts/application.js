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
//= require react
//= require components
//= require react_ujs
//= require pickadate/picker
//= require pickadate/picker.date
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

  /* TODO: all of this needs to be objectified */

  /*
    pickadate.js
  */
  $(".pickadate").pickadate({
    format: 'mmmm d, yyyy'
  });

  /*
    flash alerts
  */

  var flash = $("#top-flash");
  var flash_exists = (flash.children().length > 0) ? true : false;
  var flash_fade_time = 300;
  var flash_delay_time = 4500;

  if(flash_exists){
    flash.children("div").append($('<a href="#" id="flash-close" class="">(close)</a>)'));
    flash.delay(flash_delay_time).fadeOut(flash_fade_time);
  }else{
    flash.hide();
  }

  $("#flash-close").on('click', function(){
    flash.stop().fadeOut(flash_fade_time);
    return false;
  });

  /*
    turn off the lights for video
  */

  var current_body_color = $("div.main-content").css("background-color");
  var animate_time = 300;
  var turn_dark_els = $("body,div.main-content,footer");
  var is_dark = false;

  $("a#off-lights").on('click', function(e){

    e.preventDefault();

    var color = is_dark ? current_body_color : "#1e1e1e";
    var text = is_dark ? "Turn Off the Lights" : "Turn On the Lights";

    turn_dark_els.stop().animate({ backgroundColor: color}, animate_time);
    $(this).html(text);

    $(".top-bar-container").slideToggle(animate_time);
    $("h5.video-title,a.video-action").toggleClass("dark");

    is_dark = !is_dark;

     return false;

  });

  /*
    disable file uploads until file selected
  */
  $upload_input = $("#document_file");
  $upload_button = $("#document_file_button");

  $upload_button.attr('disabled',true);
  $upload_input.change(
      function(){
          if ($(this).val()){
              $upload_button.removeAttr('disabled');
          }
          else {
              $upload_button.attr('disabled',true);
          }
      });

  /*
    slide reveal
  */

  // Set the text for depressed buttons that reveal a panel
  function set_reveal_text(el){
    if(el.data("initial")){
      el.html((el.hasClass('revealing')) ? el.data('active') : el.data('initial'));
    }
  }

  $("a.slide-reveal").each(function(){
    set_reveal_text($(this));
  });

  /*
    lecture text parsing
  */
  var $lectureDescription = $("p.lecture-description");
  if($lectureDescription.length){
    $lectureDescription.html(Autolinker.link($lectureDescription.html()));
  }

  /*
    youtube parsing
  */
  var YoutubeParser = {

    // courtesy of https://gist.github.com/takien/4077195
    get_id: function(url){
      var youtube_id = '';
      url = url.replace(/(>|<)/gi,'').split(/(vi\/|v=|\/v\/|youtu\.be\/|\/embed\/)/);
      if(url[2] !== undefined) {
        youtube_id = url[2].split(/[^0-9a-z_]/i);
        youtube_id = youtube_id[0];
      }
      else {
        youtube_id = "false";
      }
      return youtube_id;
    },

    youtube_iframe_for_id: function(youtube_id){
      return '<iframe width="560" height="315" src="//www.youtube.com/embed/' + youtube_id + '" frameborder="0" allowfullscreen></iframe>';
    },

    get_html: function(url){
      var youtube_id = this.get_id(url);
      if(youtube_id == "false"){
        return '';
      }else{
        return this.youtube_iframe_for_id(youtube_id);
      }
    },

  };

  // Manage AJAX requests for maintaining the state of open panels
  var management_state = {

    // Get the state from the server, open relevant panels
    // This is called when the document loads

    get: function(){
      $.post("/management_state", {open_panels: "get"}, function(response){
        management_state.open_panels(String(response));
      });
    },

    // Persist the current state to a cookie
    // This is called when it modified (i.e. a button click)
    set: function(state){
      $.post("/management_state", {open_panels: state}, function(response){});
    },

    // Open panels that should be revealed based on state
    open_panels: function(p){
        var panels = String(p).split(',');
        for(var i = 0; i < panels.length; i++){
          if(panels[i] == " ") continue;
          var panel_el = $("#" + panels[i]);
          if(panel_el.length){
            panel_el.addClass('revealed').show();
            var link_showing = $("a[data-reveal='" + panel_el.attr('id') + "']");
            link_showing.addClass('revealing').html(link_showing.data('active'));
          }
        }
    }

  };

  $("a.slide-reveal").on('click', function(e){

    e.preventDefault();

    // reveal/hide and change text if necessary
    $(this).toggleClass('revealing');
    $("#" + $(this).data('reveal')).slideToggle(200).toggleClass('revealed');
    set_reveal_text($(this));

    // send a cookie with the management state
    var open_panels = [];
    $('div.reveal-hidden').each(function(){
      if($(this).hasClass('revealed')){
        open_panels.push($(this).attr('id'));
      }
    });
    management_state.set(open_panels.join(','));

  });

  // on document load, get the state from a cookie
  // if it exists
  management_state.get();

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

      $capsule = $("[data-capsule-id=" + capsule + "]");
  		$capsule.addClass("active");

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
       c = typeof c !== 'undefined' ? c : false;
       p = typeof p !== 'undefined' ? p : false;
       i = typeof i !== 'undefined' ? i : false;
       if(c && p && i && (c * p * i) > 0){
         this.navigateToCapsule(c).navigateToType(p).navigateToItem(i);
       }else if(c && p && (c * p) > 0){
         this.navigateToCapsule(c).navigateToType(p);
       }else if(c && c > 0){
         this.navigateToCapsule(c);
       }
  	}

  }

  /* forms */

  if($("#lecture-comments").length){

    var lecture_id = $("#lecture-comments").data("lecture-id");
    var list_url = $("#lecture-comments").data("url");
    var loaded_comment_ids = [];

    var get_comment_content = function(comment){
      var self = comment;
      var content = "<p class='lecture-comment'>";
      content += "<strong>" + self.author.display_identifier + "</strong>: ";
      content += Autolinker.link(html_escape(self.body));
      content += "&nbsp;&nbsp;<span class='comment-date' data-time='" + self.posted_time + "'></span> ";
      content += YoutubeParser.get_html(self.body);
      content += "</p>";
      return content;
    }

    var push_comments_to_dom = function(comments){

      var $container = $("#lecture-comments");

      $container.children('p.empty').remove();

      if(comments.length == 0){
        $container.html("<p class='empty'>No comments yet! Be the first.</p>")
      }

      $.each(comments, function() {
        if($.inArray(this.id, loaded_comment_ids)!==-1)
          return true;
        loaded_comment_ids.push(this.id);
        var comment = get_comment_content(this);
        $container.prepend(comment);
      });

      // update the date for each comment
      $('p.lecture-comment').each(function(){
          $span = $(this).children('span.comment-date');
          $span.html($.timeago($span.data('time')));
      });

    }

    var download_latest_comments = function(){

      $.ajax({
        type: "GET",
        url: list_url,
        data: {lecture: lecture_id}
      }).done(function(comments) {
        push_comments_to_dom(comments);
        setTimeout(download_latest_comments, 300);
      }).fail(function(error, as){
        console.log('Getting latest comments failed!');
        push_comments_to_dom([]);
        setTimeout(download_latest_comments, 2000);
      });

    }

    download_latest_comments();

    $("#comments-submit").on("ajax:success", function(){
      $("#comment-body").val("").select();
      download_latest_comments();
    });

    $("#lecture-comments").on("mouseover", "p", function(){
      $(this).children("span.comment-date").show();
    }).on("mouseout", "p", function(){
      $(this).children("span.comment-date").hide();
    });

  }

  if($(".mobile-nav").css("display")!="none"){
    var medium = true;
    var small = true;
  }

  current_capsule = (typeof capsule_id == 'undefined') ? -1 : capsule_id;
  current_lecture = (typeof lecture_id == 'undefined') ? -1 : lecture_id;
  current_type = 0;

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

  if(small || medium){
    sidebar.init($(".course-accordion--mobile"));

    if(typeof capsule_id !== 'undefined'){
      sidebar.navigate(capsule_id);
      sidebar.type().click(function(e){
        e.preventDefault();
        sidebar.navigateToType(e.target.eq());
      });
    }
    if(typeof lecture_id !== 'undefined'){
      $("[data-lecture-id=" + lecture_id + "]").addClass("active");
    }

  } else {
    sidebar.init($(".course-accordion"));
    if(typeof capsule_id !== 'undefined'){
      sidebar.navigate(capsule_id);
      sidebar.type().click(function(e){
        e.preventDefault();
        sidebar.navigateToType($(e.target).parent().index());
      });
    }

    if(typeof lecture_id !== 'undefined'){
      $("[data-lecture-id=" + lecture_id + "]").addClass("active");
    }

  }

}

});
