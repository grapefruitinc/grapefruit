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
#  mediasite_url  :string(255)
#

class Lecture < ActiveRecord::Base

	validates :name, presence: true
	validates :lecture_number, presence: true
  
  has_many :documents, dependent: :destroy

	belongs_to :capsule
	
end
