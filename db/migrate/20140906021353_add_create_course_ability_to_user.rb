class AddCreateCourseAbilityToUser < ActiveRecord::Migration
  def change
    add_column :users, :can_create_courses, :boolean, default: false
  end
end
