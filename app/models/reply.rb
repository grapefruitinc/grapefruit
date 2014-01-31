# == Schema Information
#
# Table name: replies
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  topic_id   :integer
#  author_id  :integer
#  body       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Reply < ActiveRecord::Base

  # Validations
  # ========================================================
  validates :body, presence: true
  validates :course_id, presence: true
  validates :topic_id, presence: true
  validates :author_id, presence: true

  # Relationships
  # ========================================================
  belongs_to :course
  belongs_to :author, class_name: "User"
  belongs_to :topic

end
