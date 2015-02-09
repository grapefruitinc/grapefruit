$(document).ready(function(){

  $(".grade-update").on("click", function(){

    var $parent = $(this).parent().parent();

    // perform the grade update operation
    var assignment_id = $parent.data("assignment-id");
    var user_id = $parent.data("user-id");
    var comments = $parent.find("textarea.comments").val();
    var points = parseFloat($parent.find("input.points").val());
    if(!$.isNumeric(points)){
      alert("Point value must be a number!");
    }else{

      // premptively show the user a success message
      $parent.children("h6.green").show();
      $parent.children("h6.yellow").hide();

      $.ajax({ type: "POST", url: window.location, data: {
        points: points,
        comments: comments,
        assignment_id: assignment_id,
        user_id: user_id
      }});

    }
  });

  $("input.points").on("input", function(){
    var points = parseFloat($(this).val());
    var total_points = parseFloat($(this).data("total-points"));
    var percentage = points / total_points * 100;
    if(!$.isNumeric(percentage))
      percentage = 0;
    $(this).parent().find("span.percentage").html(percentage.toFixed(2));
  });

});
