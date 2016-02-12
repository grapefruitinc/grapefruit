class AddRoleToCourseUser < ActiveRecord::Migration
  def change
    add_column :course_users, :role, :integer, default: 0
  end
end
