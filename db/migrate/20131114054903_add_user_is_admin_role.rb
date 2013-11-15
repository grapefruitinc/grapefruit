class AddUserIsAdminRole < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, :default => nil
  end
end
