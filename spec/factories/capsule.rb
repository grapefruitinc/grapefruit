FactoryGirl.define do

  factory :capsule do
    sequence(:name) { |n| "Capsule #{n}" }
    association :course, factory: :course
  end

end