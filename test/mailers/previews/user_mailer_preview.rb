class UserMailerPreview < ActionMailer::Preview
  def new_announcement
    UserMailer.to_class(User.first, User.last, Course.first, "Sample Subject", "Sample Message")
  end
  def new_assignment
    UserMailer.new_assignment(User.first, Course.first, Assignment.first)
  end
end
