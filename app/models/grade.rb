# == Schema Information
#
# Table name: grades
#
#  id            :integer          not null, primary key
#  points        :float(24)
#  comments      :string(255)
#  assignment_id :integer
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Grade < ActiveRecord::Base

  validates :points, presence: true

  belongs_to :assignment
  belongs_to :user
  has_many :documents, dependent: :destroy

  def percentage
    ((self.points / self.assignment.points) * 100).round(0)
  end

end
