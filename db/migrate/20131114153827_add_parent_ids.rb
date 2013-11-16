class AddParentIds < ActiveRecord::Migration
  def change
  	add_column :capsules, :course_id, :integer
  	add_column :lectures, :capsule_id, :integer
  	add_column :problem_sets, :capsule_id, :integer
  end
end
