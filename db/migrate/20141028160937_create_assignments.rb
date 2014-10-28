class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :description
      t.float :points
      t.integer :course_id
      t.integer :assignment_type_id

      t.timestamps
    end
  end
end
