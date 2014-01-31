class AddCapsuleIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :capsule_id, :integer
  end
end
