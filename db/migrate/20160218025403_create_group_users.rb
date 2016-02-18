class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.references :group, index: true
      t.references :course_user, index: true

      t.timestamps null: false
    end
  end
end
