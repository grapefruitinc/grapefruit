class AddYoutubeVideoIdToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :youtube_id, :string
  end
end
