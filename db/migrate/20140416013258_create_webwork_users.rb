class CreateWebworkUsers < ActiveRecord::Migration
  def change
    create_table :webwork_users do |t|

      t.timestamps
    end
  end
end
