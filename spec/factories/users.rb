FactoryGirl.define do
  factory :user do
    name { FFaker::Name.name }
    password "Passw0rd"
    password_confirmation { |u| u.password }

    sequence(:email) { |n| "test#{n}@example.com" }
  end

end
