# == Schema Information
#
# Table name: video_texts
#
#  id         :integer          not null, primary key
#  content    :text(65535)
#  time       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  video_id   :integer
#

class VideoText < ActiveRecord::Base

  validates :content, presence: true
  validates :time, presence: true

  belongs_to :video

end
