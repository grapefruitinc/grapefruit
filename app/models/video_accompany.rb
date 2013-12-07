# == Schema Information
#
# Table name: video_accompanies
#
#  id         :integer          not null, primary key
#  content    :text
#  time       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class VideoAccompany < ActiveRecord::Base

  validates :content, presence: true
  validates :time, presence: true

  belongs_to :video

end
