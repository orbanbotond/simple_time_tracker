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
