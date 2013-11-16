# == Schema Information
#
# Table name: problem_sets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ProblemSet < ActiveRecord::Base

	validates :name, presence: true

	belongs_to :capsule

end
