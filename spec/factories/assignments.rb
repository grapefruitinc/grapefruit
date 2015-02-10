# == Schema Information
#
# Table name: assignments
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :string(255)
#  points             :float(24)
#  course_id          :integer
#  assignment_type_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#  reveal_day         :date
#  due_day            :date
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    name "MyString"
    description "MyString"
    points 1.5
    course_id 1
    assignment_type_id 1
  end
end
