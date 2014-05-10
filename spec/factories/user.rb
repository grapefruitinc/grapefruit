FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password "grapefruit"
    password_confirmation "grapefruit"
    is_admin false
  end

end