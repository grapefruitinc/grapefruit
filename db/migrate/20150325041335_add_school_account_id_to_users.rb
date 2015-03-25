class AddSchoolAccountIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school_account_id, :integer
    add_index :users, :school_account_id
  end
end
