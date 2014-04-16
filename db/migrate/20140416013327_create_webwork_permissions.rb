class CreateWebworkPermissions < ActiveRecord::Migration
  def change
    create_table :webwork_permissions do |t|

      t.timestamps
    end
  end
end
