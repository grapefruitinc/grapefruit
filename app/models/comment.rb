# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  lecture_id :integer
#  author_id  :integer
#  body       :string(700)
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base

  validates_presence_of :lecture_id, :author_id, :body

  belongs_to :lecture
  belongs_to :author, class_name: "User"

end
