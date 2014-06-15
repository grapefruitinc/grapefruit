module ActiveModel
  class Errors
    def full_unique_messages
      unique_messages = messages.map { |attribute, list_of_messages| [attribute, list_of_messages.first] }
      unique_messages.map { |attribute_message_pair| full_message *attribute_message_pair }
    end
  end
end