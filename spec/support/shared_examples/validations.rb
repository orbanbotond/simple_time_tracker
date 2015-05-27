RSpec.shared_examples 'date can not be in the future' do
  specify 'proper error message is added for the date field' do
    expect(the_object).to_not be_valid
    expect(the_object.errors[:date]).to include('date can\'t be in the future')
  end
end

RSpec.shared_examples 'end_time is not in the future' do
  specify 'should be invalid and contain the proper error message' do
    expect(the_object).to_not be_valid
    expect(the_object.errors[:end_time]).to include('end_time can\'t be in the future')
  end
end

RSpec.shared_examples 'the start_time is before the end_time' do
  specify 'should be invalid and contain the proper error message' do
    expect(the_object).to_not be_valid
    expect(the_object.errors[:start_time]).to include('can not start after the task ends')
  end
end

RSpec.shared_examples 'overlapping times' do
  let(:start_time_overlaps) { create :work_session, start_time: 6.minutes.ago, end_time: 4.minutes.ago, work_day: work_day }
  let(:overlaps_1) { create :work_session, start_time: 6.minutes.ago, end_time: 1.minutes.ago, work_day: work_day }
  let(:overlaps_2) { create :work_session, start_time: 4.minutes.ago, end_time: 3.minutes.ago, work_day: work_day }
  let(:end_time_overlaps) { create :work_session, start_time: 3.minutes.ago, end_time: 1.minutes.ago, work_day: work_day }

  specify 'start time overlaps' do
    start_time_overlaps
    expect(subject).to_not be_valid
    expect(subject.errors[:start_time]).to include('there is an overlapping work session')
  end

  specify 'overlaps' do
    overlaps_1
    expect(subject).to_not be_valid
    expect(subject.errors[:start_time]).to include('there is an overlapping work session')
    expect(subject.errors[:end_time]).to include('there is an overlapping work session')
  end

  specify 'overlaps' do
    overlaps_2
    expect(subject).to_not be_valid
    expect(subject.errors[:start_time]).to include('there is an overlapping work session')
    expect(subject.errors[:end_time]).to include('there is an overlapping work session')
  end

  specify 'end time overlaps' do
    end_time_overlaps
    expect(subject).to_not be_valid
    expect(subject.errors[:end_time]).to include('there is an overlapping work session')
  end
end
