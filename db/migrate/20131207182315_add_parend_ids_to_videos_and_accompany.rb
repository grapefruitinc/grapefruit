class AddParendIdsToVideosAndAccompany < ActiveRecord::Migration
  def change
    add_column :videos, :lecture_id, :integer
    add_column :video_accompanies, :video_id, :integer
  end
end
