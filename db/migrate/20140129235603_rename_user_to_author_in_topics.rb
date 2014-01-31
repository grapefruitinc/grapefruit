class RenameUserToAuthorInTopics < ActiveRecord::Migration
  def change
    rename_column :topics, :user_id, :author_id
    rename_column :replies, :user_id, :author_id
  end
end
