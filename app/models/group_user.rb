# == Schema Information
#
# Table name: group_users
#
#  id             :integer          not null, primary key
#  group_id       :integer
#  course_user_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class GroupUser < ActiveRecord::Base
  
  # Validations
  # ============================================================================
  validates :course_user_id,
    presence: true,
    uniqueness: {
      scope: :group_id,
      message: 'is already in this group.'
    }

  # Relationships
  # ============================================================================
  belongs_to :group
  belongs_to :course_user

end
