$(document).ready(function(){

  $(".grade-update").on("click", function() {
    var $parent = $(this).parent().parent();
    var points = parseFloat($parent.find("input.points").val());

    // perform the grade update operation
    var form_data = new FormData();
    form_data.append('assignment_id', $parent.data("assignment-id"));
    form_data.append('user_id', $parent.data("user-id"));
    form_data.append('comments', $parent.find("textarea.comments").val());
    form_data.append('points', points);

    jQuery.each($('.documents-uploader')[0].files, function(i, file) {
      form_data.append('documents[document][]', file);
    });

    if ($.isNumeric(points)) {
      // premptively show the user a success message
      $parent.children("h6.green").show();
      $parent.children("h6.yellow").hide();

      $.ajax({
        type: "POST",
        processData: false,
        contentType: false,
        url: window.location,
        data: form_data
      });
    } else {
      alert("Point value must be a number!");
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
