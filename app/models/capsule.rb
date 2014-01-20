# == Schema Information
#
# Table name: capsules
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  course_id  :integer
#

class Capsule < ActiveRecord::Base

	validates :name, presence: true

	belongs_to :course
	has_many :lectures, dependent: :destroy
	has_many :problem_sets, dependent: :destroy
	
end
