# == Schema Information
#
# Table name: assignment_types
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  default_point_value :float(24)
#  drops_lowest        :boolean
#  percentage          :float(24)
#  course_id           :integer
#  created_at          :datetime
#  updated_at          :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment_type do
    name "MyString"
    default_point_value 1.5
    drops_lowest ""
    percentage 1.5
    course_id 1
  end
end
