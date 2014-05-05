include ActionView::Helpers::DateHelper
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :relative_time
  has_one :author
  def relative_time
    time_ago_in_words(object.updated_at, true)
  end
end