class UserMailer < ActionMailer::Base

  default from: 'Grapefruit <' + Settings.gmail.address + '>'

  layout 'mailer_base'

  def to_class(sender, course, subject, message)
    @sender_name = sender.full_name
    @sender_email = sender.email
    @course_name = course.name
    @course_link = course_path(course)
    @announcements_link = course_announcements_path(course)
    @message = message
    course.students.each do |student|
      @student_name = student.display_identifier
      mail(to: student.email, subject: subject, reply_to: @sender_email)
    end
  end

  def new_assignment(course, assignment)
    subject = "New Assignment: #{assignment.name}"
    @course = course
    @assignment = assignment
    course.students.each do |student|
      @student_name = student.display_identifier
      mail(to: student.email, subject: subject)
    end
  end

end
