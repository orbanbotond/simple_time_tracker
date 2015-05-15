FactoryGirl.define do
  factory :user do
    name { FFaker::Name.name }
    sequence(:email) { |n| "test#{n}@example.com" }
  end

end
