# == Schema Information
#
# Table name: course_users
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class CourseUser < ActiveRecord::Base

  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :course

end
