class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :lecture_id
      t.integer :author_id
      t.string :body

      t.timestamps
    end
  end
end
