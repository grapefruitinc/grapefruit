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
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(function() {

  $(document).foundation();   

  var flash = $("div#top-flash div.alert-box");

  var current_flash_color = flash.css("backgroundColor");
  var highlight_flash_color = flash.parent().css("backgroundColor"); 
    
  flash.stop().delay(280)
    .animate({ backgroundColor: highlight_flash_color }, 200)
    .animate({ backgroundColor: current_flash_color }, 300);  


  var accordion = $(".course-accordion");
  var capsule = $(".course-capsule");
  var capsule_nav_item = $(".capsule-nav li");

  
  capsule.click(function(){
  	$this = $(this);
  	if($this.hasClass("active")){return;}
  	$this.siblings().removeClass("active").animate({height: "2.5rem"}, 250);
  	$this.addClass("active");
  	$this.animate({
  		height: $this.children("ul.capsule-contents").outerHeight()+(40)
  	}, 250, function(){
	    $(".capsule-contents").outerHeight($this.outerHeight()-40);
  	});
  });


  capsule_nav_item.click(function(){
  	$this = $(this);
  	new_index = $this.index();
  	capsule_contents = $(".course-capsule.active .capsule-contents");

  	capsule_contents.removeClass("active").first().animate({
  		marginLeft: ((-100*new_index) + "%")
  	}, 250);

  	$(".course-capsule.active").removeClass("active");
  	console.log($(".course-capsule").eq(new_index));
  	capsule_contents.eq(new_index).addClass("active");

  	$this.siblings().removeClass("active");
  	$this.addClass("active");

  });


});
