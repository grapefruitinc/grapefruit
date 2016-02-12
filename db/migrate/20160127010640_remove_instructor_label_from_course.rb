class RemoveInstructorLabelFromCourse < ActiveRecord::Migration
  def change
    remove_column :courses, :instructor_label, :string
  end
end
