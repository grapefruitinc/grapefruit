include ActionView::Helpers::DateHelper
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :posted_time
  has_one :author
  def posted_time
    object.updated_at
  end
end
