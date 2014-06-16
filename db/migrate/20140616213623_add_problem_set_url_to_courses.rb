class AddProblemSetUrlToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :problem_set_url, :text
  end
end
