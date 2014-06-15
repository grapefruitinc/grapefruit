class AddLiveToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :live, :boolean, default: false
  end
end
