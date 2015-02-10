# == Schema Information
#
# Table name: assignments
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :string(255)
#  points             :float(24)
#  course_id          :integer
#  assignment_type_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#  reveal_day         :date
#  due_day            :date
#

class Assignment < ActiveRecord::Base

  validates :name, presence: true
  validates :points, presence: true
  validates :assignment_type, presence: true

  belongs_to :course
  belongs_to :assignment_type
  has_many :grades, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_many :documents, dependent: :destroy

  def available_submissions
    submissions.where(updated_at: self.submissions.select("max(updated_at)").group(:user_id)).order("updated_at desc")
  end

end
