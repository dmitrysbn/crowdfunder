FactoryGirl.define do
  factory :user do
    password_confirmation 'password'
    password 'password'
    sequence(:email) { |n| "test#{n}@test.com"}
  end
end
