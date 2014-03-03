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
  		paddingBottom: $this.children("ul.capsule-contents.active").outerHeight()+(32)
  	}, 500, function(){
  		// all done
  	});
  });


  capsule_nav_item.click(function(){
  	$this = $(this);
  	old_index = $(".capsule-contents.active").index()-1;
  	new_index = $this.index();
  	console.log(old_index);
  	console.log(new_index);


  	$(".course-capsule.active .capsule-contents").first().animate({
  		marginLeft: ((-100*new_index) + "%")
  	}, 500);

  	$this.siblings().removeClass("active");
  	$this.addClass("active");

  });


});
