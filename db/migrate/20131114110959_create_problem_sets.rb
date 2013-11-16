class CreateProblemSets < ActiveRecord::Migration
  def change
    create_table :problem_sets do |t|
      t.string :name

      t.timestamps
    end
  end
end
