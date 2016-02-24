# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base

  belongs_to :course
  
  has_many :group_users, dependent: :destroy
  has_many :course_users, class_name: 'CourseUser', through: :group_users, source: :course_user

  # Helper methods
  # ========================================================

  # Expects an array of course_user_ids to add to the group
  def add_group_users(course_user_ids)
    new_group_users = []

    course_user_ids - group_users.all.pluck(:course_user_id)

    course_user_ids.each do |course_user_id|
      new_group_users.push GroupUser.new(course_user_id: course_user_id, group: self)
    end

    GroupUser.import new_group_users, validate: false
  end

  def modify_group_users(course_user_ids)
    current_ids = group_users.all.pluck(:course_user_id)

    new_ids = course_user_ids - group_users.all.pluck(:course_user_id)
    removed_ids = current_ids - course_user_ids

    puts "new_ids #{new_ids}"
    puts "removed_ids #{removed_ids}"
  end

  def remove_student(course_user_id)
    self.group_users.where(course_user_id: course_user_id).destroy_all
  end

  def course_user(course_user_id)
    self.group_users.find_by_course_user_id(course_user_id)
  end

end
