FactoryGirl.define do
  factory :work_session do
    description "MyString"
    start_time { 2.minutes.ago }
    end_time { 1.minute.ago }
    work_day
  end
end
