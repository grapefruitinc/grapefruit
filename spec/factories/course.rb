FactoryGirl.define do

  factory :course do
    sequence(:name) { |n| "Course #{n}" }
    association :instructor, factory: :user
  end

end