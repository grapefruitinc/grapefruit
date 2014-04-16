class CreateWebworkPasswords < ActiveRecord::Migration
  def change
    create_table :webwork_passwords do |t|

      t.timestamps
    end
  end
end
