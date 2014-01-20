class CreateCourseUsers < ActiveRecord::Migration
  def change
    create_table :course_users do |t|
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end
  end
end
