# == Schema Information
#
# Table name: grades
#
#  id            :integer          not null, primary key
#  points        :float
#  comments      :string(255)
#  assignment_id :integer
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Grade < ActiveRecord::Base

  validates :points, presence: true

  belongs_to :assignment
  has_many :documents, dependent: :destroy

end
