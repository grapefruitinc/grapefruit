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

	# attr_accessible :name

	validates :name, presence: true

	belongs_to :instructor, class_name: "User"
	has_and_belongs_to_many :students, class_name: "User"
  has_many :capsules, dependent: :destroy

end
