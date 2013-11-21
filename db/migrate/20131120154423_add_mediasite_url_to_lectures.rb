class AddMediasiteUrlToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :mediasite_url, :string
  end
end