# == Schema Information
#
# Table name: lectures
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  lecture_number :integer
#  created_at     :datetime
#  updated_at     :datetime
#  capsule_id     :integer
#  description    :text
#

class Lecture < ActiveRecord::Base

  # Validations
  # ========================================================
  validates :name, presence: true
  validates :lecture_number, presence: true

  # Relationships
  # ========================================================
  has_many :documents, dependent: :destroy

	belongs_to :capsule

  has_many :videos

end
