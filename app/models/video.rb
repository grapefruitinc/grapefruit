# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#

class Video < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true

  belongs_to :lecture
end
