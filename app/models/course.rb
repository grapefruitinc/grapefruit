# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Course < ActiveRecord::Base

	attr_accessible :name

	validates :name, presence: true

	belongs_to :user
	has_many :lectures, dependent: :destroy

end
