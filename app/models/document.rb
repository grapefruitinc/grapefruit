# == Schema Information
#
# Table name: documents
#
#  id          :integer          not null, primary key
#  file        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  course_id   :integer
#  capsule_id  :integer
#  lecture_id  :integer
#

class Document < ActiveRecord::Base

  # Files
  # ========================================================
  mount_uploader :file, DocumentUploader

  # Validations
  # ========================================================
  validates :file, presence: true

  # Relationships
  # ========================================================
  belongs_to :course
  belongs_to :capsule
  belongs_to :lecture
  
end
