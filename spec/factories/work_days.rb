FactoryGirl.define do
  factory :work_day do
    user
    duration 1
    date { Time.now }
  end

end
