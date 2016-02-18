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
#  group_id      :integer
#

class Submission < ActiveRecord::Base

  # Validations
  # ============================================================================
  validate :user_or_group

  # Relationships
  # ========================================================
  belongs_to :assignment
  belongs_to :user
  belongs_to :group
  has_many :documents, dependent: :destroy

private

  def user_or_group
    if user_id.blank? && group_id.blank?
      errors.add(:base, 'Submission must belong to either a group, or user.')
    elsif !user_id.blank? && !group_id.blank?
      errors.add(:base, 'Submission can either belong to either a group, or user, not both.')
    end
  end

end
