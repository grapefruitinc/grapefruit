# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  lecture_id  :integer
#  file        :string(255)
#  youtube_id  :string(255)
#

class Video < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  
  belongs_to :lecture
end
