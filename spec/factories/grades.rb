# == Schema Information
#
# Table name: grades
#
#  id            :integer          not null, primary key
#  points        :float
#  comments      :string(255)
#  assignment_id :integer
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grade do
    points 1.5
    comments "MyString"
    assignment_id 1
    user_id 1
  end
end
