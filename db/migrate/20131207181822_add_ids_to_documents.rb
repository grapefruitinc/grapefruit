class AddIdsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :course_id, :integer
    add_column :documents, :capsule_id, :integer
    add_column :documents, :lecture_id, :integer
    # whoops
    remove_column :courses, :document_id
    remove_column :capsules, :document_id
    remove_column :lectures, :document_id
  end
end
