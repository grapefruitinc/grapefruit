class AddUserReferencesToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :instructor_id, :integer
    add_column :courses, :student_id, :integer
  end
end
