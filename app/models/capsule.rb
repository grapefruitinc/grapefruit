# == Schema Information
#
# Table name: capsules
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Capsule < ActiveRecord::Base

	validates :name, presence: true

	belongs_to :course
	has_many :lectures, dependent: :destroy
	has_many :problemsets, dependent: :destroy
	
end
