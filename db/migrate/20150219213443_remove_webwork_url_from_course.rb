class RemoveWebworkUrlFromCourse < ActiveRecord::Migration
  def change
    remove_column :courses, :webwork_url
  end
end
