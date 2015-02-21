$(function() {

  /* parse text for lectures */

  var $lectureDescription = $("p.lecture-description");
  if($lectureDescription.length){
    $lectureDescription.html(Autolinker.link($lectureDescription.html()));
  }

});
