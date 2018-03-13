FactoryGirl.define do
  factory :project do
    sequence(:title) { |n| "Project #{n}"}
    description 'test'
    goal 500.00
    start_date Date.today + 1.day
    end_date  Date.today + 1.month
    association :owner, factory: :user
  end
end
