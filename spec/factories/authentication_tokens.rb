FactoryGirl.define do
  factory :authentication_token do
    token "MyString"
    expires_at 1.day.from_now
    user
  end
end
