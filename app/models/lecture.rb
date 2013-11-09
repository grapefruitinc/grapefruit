# == Schema Information
#
# Table name: lectures
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  lecture_number :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Lecture < ActiveRecord::Base

	attr_accessible :name, :lecture_number

	validates :name, presence: true
	validates :lecture_number, presence: true

	belongs_to :course
	
end
