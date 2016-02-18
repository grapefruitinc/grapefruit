# == Schema Information
#
# Table name: course_users
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  role       :integer          default(0)
#

class CourseUser < ActiveRecord::Base
  
  # constants for role column
  STUDENT = 0
  INSTRUCTOR = 1
  ASSISTANT = 2

  # Relationships
  # ========================================================
  belongs_to :user
  belongs_to :course

end
