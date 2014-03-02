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
  	$this.siblings().removeClass("active").animate({paddingBottom: "0"}, 250);
  	$this.addClass("active");
  	$this.animate({
  		paddingBottom: "10rem"
  	}, 500, function(){
  		// all done
  	});
  });


  capsule_nav_item.click(function(){
  	id = $(this).attr("data-capsule-controller");
  	$("ul[data-capsule-receiver].active").animate({
  		width: "0px"
  	}, 500, function(){
  		$(this).removeClass("active");
  	});
  	accordion.find("ul[data-capsule-receiver='" + id + "']").addClass("active");
  });


});
