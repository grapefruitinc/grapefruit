class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :display_identifier
  def display_identifier
    object.display_identifier
  end
end
