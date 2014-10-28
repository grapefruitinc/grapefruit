# == Schema Information
#
# Table name: submissions
#
#  id            :integer          not null, primary key
#  comments      :string(255)
#  user_id       :integer
#  assignment_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Submission < ActiveRecord::Base

  belongs_to :assignment
  has_many :documents, dependent: :destroy

end
