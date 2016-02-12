class RemoveInstructorIdFromCourse < ActiveRecord::Migration
  def change
    # create an instructor course_user role for existing courses that have an instructor_id field
    Course.all.each do |course|
      CourseUser.create!(
        course_id: course.id,
        user_id: course.instructor_id,
        role: CourseUser::INSTRUCTOR)
    end
    # remove the instructor_id field for future courses
    remove_column :courses, :instructor_id
  end
end
