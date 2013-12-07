class AddDocumentIds < ActiveRecord::Migration
  def change
    add_column :courses, :document_id, :integer
    add_column :capsules, :document_id, :integer
    add_column :lectures, :document_id, :integer
  end
end
