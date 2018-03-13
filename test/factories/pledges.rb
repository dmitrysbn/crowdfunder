FactoryGirl.define do
  factory :pledge do
    user
    project
    dollar_amount 20.00
  end
end
