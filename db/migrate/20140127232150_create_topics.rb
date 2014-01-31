class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :replies, default: 0
      t.integer :course_id
      t.integer :user_id
      t.integer :last_poster_id
      t.string :name
      t.string :body

      t.timestamps
    end
  end
end
