FactoryGirl.define do

  factory :course do
    sequence(:name)                       { |n| "Course #{n}" }
    sequence(:description)                { |n| "Description #{n}" }
    sequence(:subject)                    { |n| "Subject #{n}" }
    sequence(:course_number)              { "Course Number CSCI#{1000 + rand(8999)}" }
    sequence(:course_registration_number) { "Course Registration Number CRN#{100 + rand(899)}" }
    sequence(:semester)                   { |n| "#{%W{Fall Spring}.shuffle.first}" }
    sequence(:year)                       { 2015 }
    sequence(:spots_available)            { 10 + rand(390) }
    sequence(:credits)                    { 1 + rand(3) }
    association :instructor, factory: :user
  end

end