// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

/**
  add a nice box shadow for the page header
**/
$(document).scroll(function() {
  var ph = $('div.page-header-container');
  var bar = $('div.top-bar-container');
  var shadow = "0px 3px 14px 10px #ddd";
  var current = $(document).scrollTop();
  if(ph.height != 0){
    var content_offset = ph.offset().top + ph.height() - 21;
    if(current < content_offset || current <= 0){
      bar.css("box-shadow", "none");
    }else{
      bar.css("box-shadow", shadow);
    }
  }
});