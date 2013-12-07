class ChangeDescriptionToText < ActiveRecord::Migration
  def change
    remove_column :videos, :description
    add_column :videos, :description, :text
  end
end
