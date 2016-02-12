class RemoveTypeFromCourseUser < ActiveRecord::Migration
  def change
    if column_exists? :course_users, :type
      remove_column :course_users, :type
    end
  end
end
