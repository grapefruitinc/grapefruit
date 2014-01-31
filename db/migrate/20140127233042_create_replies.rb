class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :course_id
      t.integer :topic_id
      t.integer :user_id
      t.string :body

      t.timestamps
    end
  end
end
