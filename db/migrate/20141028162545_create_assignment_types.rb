class CreateAssignmentTypes < ActiveRecord::Migration
  def change
    create_table :assignment_types do |t|
      t.string :name
      t.float :default_point_value
      t.boolean :drops_lowest
      t.float :percentage
      t.integer :course_id

      t.timestamps
    end
  end
end
