$(function() {

  /*
    disable file uploads until file selected
  */
  $upload_input = $("#document_file");
  $upload_button = $("#document_file_button");

  $upload_button.attr('disabled',true);
  $upload_input.change(
      function(){
          if ($(this).val()){
              $upload_button.removeAttr('disabled');
          }
          else {
              $upload_button.attr('disabled',true);
          }
      });

});
