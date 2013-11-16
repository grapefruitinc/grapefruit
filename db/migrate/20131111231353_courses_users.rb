class CoursesUsers < ActiveRecord::Migration
  def change
    create_table :courses_users do |t|
      t.belongs_to :course
      t.belongs_to :user
    end
  end
end
