class CreateSchoolAccounts < ActiveRecord::Migration
  def change
    create_table :school_accounts do |t|
      t.string :name
      t.string :url
      t.string :short_name

      t.timestamps null: false
    end
  end
end
