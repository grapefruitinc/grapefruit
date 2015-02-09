class UserMailerPreview < ActionMailer::Preview
  def to_class
    UserMailer.to_class(User.first, Course.first, "Sample Subject", "Sample Message")
  end
  def new_assignment
    UserMailer.new_assignment(Course.first, Assignment.first)
  end
end
