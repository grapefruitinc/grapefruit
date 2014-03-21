class ActuallyTheseAreNeeded < ActiveRecord::Migration
  def change
    add_column :documents, :course_id, :integer
    add_column :documents, :capsule_id, :integer
    add_column :documents, :lecture_id, :integer
  end
end
