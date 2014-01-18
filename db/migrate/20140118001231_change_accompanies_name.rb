class ChangeAccompaniesName < ActiveRecord::Migration
  def change
    rename_table :video_accompanies, :video_texts
  end
end
