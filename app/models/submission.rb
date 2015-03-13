# == Schema Information
#
# Table name: submissions
#
#  id            :integer          not null, primary key
#  comments      :text(65535)
#  user_id       :integer
#  assignment_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Submission < ActiveRecord::Base

  belongs_to :assignment
  belongs_to :user
  has_many :documents, dependent: :destroy

end
