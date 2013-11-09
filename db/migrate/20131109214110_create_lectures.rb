class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :name
      t.integer :lecture_number

      t.timestamps
    end
  end
end
