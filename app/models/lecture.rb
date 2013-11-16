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
#

class Lecture < ActiveRecord::Base

	validates :name, presence: true
	validates :lecture_number, presence: true

	belongs_to :capsule
	
end
