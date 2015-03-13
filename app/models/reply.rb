# == Schema Information
#
# Table name: replies
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  topic_id   :integer
#  author_id  :integer
#  body       :text(65535)
#  created_at :datetime
#  updated_at :datetime
#

class Reply < ActiveRecord::Base

  # Validations
  # ========================================================
  validates_presence_of :body, :course_id, :topic_id, :author_id

  # Relationships
  # ========================================================
  belongs_to :course
  belongs_to :author, class_name: "User"
  belongs_to :topic

end
