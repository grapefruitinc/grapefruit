# == Schema Information
#
# Table name: videos
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  description   :text(65535)
#  lecture_id    :integer
#  file          :string(255)
#  youtube_id    :string(255)
#  mediasite_url :string(500)
#

class Video < ActiveRecord::Base

  # Validations
  # ========================================================
  validate :only_one_type_of_video
  
  validates :title, presence: true
  validates :description, presence: true, if: :youtube_id

  validates_associated :lecture

  # Relationships
  # ========================================================
  belongs_to :lecture
  has_many :video_texts
  
  def may_be_processing
    minutes_since_uploaded = ((Time.now - updated_at) / 1.minute).round
    return (minutes_since_uploaded < 120)
  end

private

  def only_one_type_of_video
    if not (youtube_id.blank? ^ mediasite_url.blank?)
      errors.add :base, 'You can only have one type of video'
      false
    end
  end

end
