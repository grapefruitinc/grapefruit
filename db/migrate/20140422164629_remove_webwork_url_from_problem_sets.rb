class RemoveWebworkUrlFromProblemSets < ActiveRecord::Migration
  def change
    remove_column :problem_sets, :webwork_url, :string
  end
end
