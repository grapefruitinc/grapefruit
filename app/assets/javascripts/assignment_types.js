$(document).ready(function(){

  /* default point handling */

  var $points_select = $("select#assignment_assignment_type_id");
  var $points_box = $("input#assignment_points");

  $points_select.on("change", function(){
      $points_box.val($("option:selected", this).data("default-points"));
  });

  $points_box.val($points_select.find(":selected").data("default-points"));

});
