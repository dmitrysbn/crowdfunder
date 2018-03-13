FactoryGirl.define do
  factory :user do
    first_name 'Betty'
    last_name 'Maker'
    password_confirmation 'password'
    password 'password'
    sequence(:email) { |n| "test#{n}@test.com"}
  end
end
