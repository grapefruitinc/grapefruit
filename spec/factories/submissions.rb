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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    comments "MyString"
    user_id 1
    assignment_id 1
  end
end
