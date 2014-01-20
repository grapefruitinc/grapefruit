class RemoveIdAssocsFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :course_id
    remove_column :documents, :capsule_id
    remove_column :documents, :lecture_id
  end
end
