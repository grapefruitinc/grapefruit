$(function() {

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

});
