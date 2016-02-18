$(function() {
  var students = $('.students-selectize').data('students');

  console.log(students);

  $('.students-selectize').selectize({
      plugins: ['remove_button'],
      delimiter: ',',
      persist: false,
      options: students,
      labelField: 'name',
      valueField: 'course_user_id',
      sortField: 'name',
      searchField: 'name'
  });
});