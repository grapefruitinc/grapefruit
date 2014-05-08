class AddWebworkUrlToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :webwork_url, :string
  end
end
