class AddDescriptionToCapsulesAndLectures < ActiveRecord::Migration
  def change
    add_column :capsules, :description, :text
    add_column :lectures, :description, :text
  end
end
