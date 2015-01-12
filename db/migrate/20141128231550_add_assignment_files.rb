class AddAssignmentFiles < ActiveRecord::Migration
  def change
  	add_column :documents, :assignment_id, :integer
  	add_column :documents, :submission_id, :integer
  end
end
