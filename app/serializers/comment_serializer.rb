class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body
  has_one :author
end
