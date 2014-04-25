class MoveMediasiteUrlToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :mediasite_url, :string
    remove_column :lectures, :mediasite_url
  end
end
