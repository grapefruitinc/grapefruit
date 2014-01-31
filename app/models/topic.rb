# == Schema Information
#
# Table name: topics
#
#  id             :integer          not null, primary key
#  replies        :integer          default(0)
#  course_id      :integer
#  author_id      :integer
#  last_poster_id :integer
#  name           :string(255)
#  body           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  capsule_id     :integer
#

class Topic < ActiveRecord::Base

  default_scope order('updated_at DESC')

  # Validations
  # ========================================================
  validates :name, presence: true
  validates :body, presence: true
  validates :course_id, presence: true
  validates :author_id, presence: true
  validates :last_poster_id, presence: true
  # Does not require a capsule_id

  # Relationships
  # ========================================================
  belongs_to :author, class_name: "User"
  belongs_to :course
  belongs_to :capsule
  belongs_to :last_poster, class_name: "User"
  has_many :replies

  # Reply definitions
  # ========================================================
  def add_reply(reply)
    reply.course_id = self.course_id
    self.last_poster_id = reply.author_id
    self.replies << reply
    update_attribute(:updated_at, Time.now)
    self.save
  end

end
