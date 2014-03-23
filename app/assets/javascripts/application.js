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

$("document").ready(function(){

  $(document).foundation();

  var flash = $("div#top-flash div.alert-box");

  var current_flash_color = flash.css("backgroundColor");
  var highlight_flash_color = flash.parent().css("backgroundColor");

  flash.stop().delay(280)
    .animate({ backgroundColor: highlight_flash_color }, 200)
    .animate({ backgroundColor: current_flash_color }, 300);


  var sidebar = {
  	init: function(a){
  		$this = a;
      capsule = $this.find(".course-capsule");
      type = $this.find(".capsule-nav li");
      originalHeight = capsule.css("height");
      marginBump = $this.find(".capsule-header").outerHeight();
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
  		if(capsule >= $this.children(".course-capsule").length || capsule == -1){return false;}

  		$capsule = $this.children(".course-capsule").eq(capsule);

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
  		$this.find(".course-capsule.active .capsule-contents.active")
			.children().removeClass("active").eq(item).addClass("active");
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
      $(".course-accordion--mobile .course-capsule").click(function(e){
        if(sidebar.capsule().hasClass("active") && $(e.target).is(".capsule-nav i")){
          sidebar.navigateToType($(e.target).parent().index());
        } else {
          sidebar.navigateToCapsule($(this).index());
        }
      });
    } else {
      sidebar.init($(".course-accordion"));
      sidebar.capsule().click(function(e){
        if(sidebar.capsule().hasClass("active") && $(e.target).is(".capsule-nav i")){
          sidebar.navigateToType($(e.target).parent().index());
        } else {
          sidebar.navigateToCapsule($(this).index());
        }
      });

    }
  });

  if($(".mobile-nav").css("display")!="none"){
    var medium = true;
    var small = true;
  }
  if(small || medium){
    sidebar.init($(".course-accordion--mobile"));
    $(".course-accordion--mobile .course-capsule").click(function(e){
      if(sidebar.capsule().hasClass("active") && $(e.target).is(".capsule-nav i")){
        sidebar.navigateToType($(e.target).parent().index());
      } else {
        sidebar.navigateToCapsule($(this).index());
      }
    });
  } else {
    sidebar.init($(".course-accordion"));
    sidebar.capsule().click(function(e){
      if(sidebar.capsule().hasClass("active") && $(e.target).is(".capsule-nav i")){
        sidebar.navigateToType($(e.target).parent().index());
      } else {
        sidebar.navigateToCapsule($(this).index());
      }
    });

  }


});