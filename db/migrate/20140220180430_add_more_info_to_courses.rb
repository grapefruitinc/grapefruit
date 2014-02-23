class AddMoreInfoToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :description, :string
    add_column :courses, :subject, :string
    add_column :courses, :course_number, :string
    add_column :courses, :course_registration_number, :string
    add_column :courses, :semester, :string
    add_column :courses, :year, :integer
    add_column :courses, :spots_available, :integer
    add_column :courses, :credits, :integer
  end
end
