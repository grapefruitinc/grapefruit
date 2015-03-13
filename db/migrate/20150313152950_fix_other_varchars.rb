class FixOtherVarchars < ActiveRecord::Migration
  def change
    change_column :grades, :comments, :text
    change_column :videos, :mediasite_url, :string, limit: 500
    change_column :topics, :body, :text
    change_column :submissions, :comments, :text
    change_column :replies, :body, :text
    change_column :documents, :description, :text
    change_column :comments, :body, :string, limit: 700
  end
end
