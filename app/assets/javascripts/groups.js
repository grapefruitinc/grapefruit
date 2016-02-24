$(function() {
  var students = $('.students-selectize').data('students');
  var groupUsers = $('.students-selectize').data('group-users');

  console.log(students);

  $('.students-selectize').selectize({
      plugins: ['remove_button'],
      delimiter: ',',
      items: groupUsers,
      persist: false,
      options: students,
      labelField: 'name',
      valueField: 'course_user_id',
      sortField: 'name',
      searchField: 'name'
  });
});