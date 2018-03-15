FactoryGirl.define do
  factory :comment do
    comment "Comment"
    user
    project
  end
end
