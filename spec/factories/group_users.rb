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

FactoryGirl.define do
  factory :group_user do
    group nil
course_user nil
  end

end
