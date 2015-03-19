class UserMailer < ActionMailer::Base

  default from: 'Grapefruit <' + Settings.gmail.address + '>'

  layout 'mailer_base'

  def new_announcement(sender, student, course, subject, message)
    @sender_name = sender.full_name
    @sender_email = sender.email
    @course_name = course.name
    @course_link = course_url(course)
    @announcements_link = course_announcements_url(course)
    @message = message
    @student_name = student.display_identifier
    mail(to: student.email, subject: subject, reply_to: @sender_email)
  end

  def new_assignment(student, course, assignment)
    subject = "New Assignment: #{assignment.name}"
    @course = course
    @assignment = assignment
    @student_name = student.display_identifier
    mail(to: student.email, subject: subject)
  end

end
