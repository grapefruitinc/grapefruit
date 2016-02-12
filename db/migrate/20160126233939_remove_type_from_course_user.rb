class RemoveTypeFromCourseUser < ActiveRecord::Migration
  def change
    remove_column :course_users, :type
  end
end
