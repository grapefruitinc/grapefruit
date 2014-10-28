class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.float :points
      t.string :comments
      t.integer :assignment_id
      t.integer :user_id

      t.timestamps
    end
  end
end
