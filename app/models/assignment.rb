# == Schema Information
#
# Table name: assignments
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :string(255)
#  points             :float
#  course_id          :integer
#  assignment_type_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Assignment < ActiveRecord::Base

  validates :name, presence: true

  belongs_to :course
  has_many :documents, dependent: :destroy

end
