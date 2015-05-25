FactoryGirl.define do
  factory :user do
    name { FFaker::Name.name }
    password "Passw0rd"
    password_confirmation { |u| u.password }

    sequence(:email) { |n| "test#{n}@example.com" }

    factory :admin do
      after(:create) do |instance|
        instance.add_role :admin
        instance.save!
      end
    end
  end
end
