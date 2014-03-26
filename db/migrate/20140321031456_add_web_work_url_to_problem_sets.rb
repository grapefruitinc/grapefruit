class AddWebWorkUrlToProblemSets < ActiveRecord::Migration
  def change
    add_column :problem_sets, :webwork_url, :text
  end
end
