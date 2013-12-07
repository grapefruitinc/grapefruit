class CreateVideoAccompanies < ActiveRecord::Migration
  def change
    create_table :video_accompanies do |t|
      t.text :content
      t.string :time

      t.timestamps
    end
  end
end
