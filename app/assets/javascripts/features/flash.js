$(function() {

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

});
