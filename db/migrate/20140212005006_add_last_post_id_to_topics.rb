class AddLastPostIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :last_post_id, :integer
  end
end
