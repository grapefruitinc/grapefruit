class AddGroupsToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :group, index: true
  end
end
