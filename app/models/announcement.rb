# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  course_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Announcement < ActiveRecord::Base

  # Validations
  # ========================================================
  validates :title, presence: true
  validates :content, presence: true

  # Relationships
  # ========================================================
  belongs_to :course

end
