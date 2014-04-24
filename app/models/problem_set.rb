# == Schema Information
#
# Table name: problem_sets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  capsule_id :integer
#

class ProblemSet < ActiveRecord::Base
  
  # Validations
  # ========================================================
  validates :name, presence: true

  # Relationships
  # ========================================================
	belongs_to :capsule

end
