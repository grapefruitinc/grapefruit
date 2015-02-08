class UserMailerPreview < ActionMailer::Preview
  def to_class
    UserMailer.to_class(User.first, Course.first, "Sample Subject", "Sample Message")
  end
end
