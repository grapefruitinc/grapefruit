class AddGradeIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :grade_id, :integer
  end
end
