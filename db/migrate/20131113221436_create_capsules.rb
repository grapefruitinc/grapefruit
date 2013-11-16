class CreateCapsules < ActiveRecord::Migration
  def change
    create_table :capsules do |t|
      t.string :name

      t.timestamps
    end
  end
end
