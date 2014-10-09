FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password "grapefruit"
    password_confirmation "grapefruit"

    factory :user_forgot_password do
      after(:create) do |user|
        raw_token, hashed_token = Devise.token_generator.generate(User, :reset_password_token)
        user.reset_password_token = hashed_token
        user.reset_password_sent_at = Time.now.utc
        # TODO: really hacky, only way I can think of to test this
        user.name = raw_token
        user.save
      end
    end
  end

end