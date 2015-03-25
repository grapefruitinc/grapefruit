# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  lecture_id :integer
#  author_id  :integer
#  body       :string(700)
#  created_at :datetime
#  updated_at :datetime
#

include ActionView::Helpers::DateHelper
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :posted_time
  has_one :author
  def posted_time
    object.updated_at
  end
end
