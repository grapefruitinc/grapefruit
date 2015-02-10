class AddDueRevealDatesToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :reveal_day, :date
    add_column :assignments, :due_day, :date
  end
end
