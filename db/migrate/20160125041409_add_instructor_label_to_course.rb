class AddInstructorLabelToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :instructor_label, :string
  end
end
