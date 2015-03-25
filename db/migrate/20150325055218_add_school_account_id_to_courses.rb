class AddSchoolAccountIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :school_account_id, :integer
    add_index :courses, :school_account_id
  end
end
