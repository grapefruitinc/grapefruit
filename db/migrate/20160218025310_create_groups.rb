class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.references :course, index: true

      t.timestamps null: false
    end
  end
end
