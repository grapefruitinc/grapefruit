FactoryGirl.define do

  factory :lecture do
    sequence(:name) { |n| "Lecture #{n}" }
    sequence(:lecture_number) { |n| n }
    sequence(:description) { |n| "Lecture description blah #{n * 10}" }

    association :capsule
  end

end
