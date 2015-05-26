require 'rails_helper'

describe TimeInput do
  context 'fields' do
    it { is_expected.to respond_to(:start_time) }
    it { is_expected.to respond_to(:end_time) }
    it { is_expected.to respond_to(:date) }
    it { is_expected.to respond_to(:description) }

    let(:start_time) { '02:20' }
    let(:end_time) { '03:40' }
    let(:date) { Date.parse('2014-05-18') }
    let(:time_input) { TimeInput.new start_time: start_time, end_time: end_time, date: date }
    context '#start_time' do
      specify 'returns the year month day set in date' do
        expect(time_input.start_time.year).to eq(date.year)
        expect(time_input.start_time.month).to eq(date.month)
        expect(time_input.start_time.day).to eq(date.day)
      end
    end
    context '#end_time' do
      specify 'returns the year month day set in date' do
        expect(time_input.end_time.year).to eq(date.year)
        expect(time_input.end_time.month).to eq(date.month)
        expect(time_input.end_time.day).to eq(date.day)
      end
    end
  end   

  context 'validations' do
    let(:params) { { description: 'lorem', start_time: '08:21', end_time: '09:12', date: '03/15/2015' } }
    specify 'description should be present' do
      expect(TimeInput.new params.except(:description)).to_not be_valid
    end
    specify 'start_time should be present' do
      expect(TimeInput.new params.except(:start_time)).to_not be_valid
    end
    specify 'end_time should be present' do
      expect(TimeInput.new params.except(:end_time)).to_not be_valid
    end
    specify 'date should be present' do
      expect(TimeInput.new params.except(:date)).to_not be_valid
    end

    context 'validates that the start_time is before the end_time' do
      let(:time_input) { TimeInput.new start_time: '08:00', end_time: '07:59', description: 'Lorem', date: '25/05/2015' }

      specify 'should be invalid and contain the proper error message' do
        expect(time_input).to_not be_valid
        expect(time_input.errors[:start_time]).to include('can not start after the task ends')
      end
    end

    context 'validates that the end_time is not in the future' do
      let(:time_input) { TimeInput.new start_time: '08:00', end_time: 2.minutes.from_now, description: 'Lorem', date: Time.zone.now }

      specify 'should be invalid and contain the proper error message' do
        expect(time_input).to_not be_valid
        expect(time_input.errors[:end_time]).to include('end_time can\'t be in the future')
      end
    end

    context 'validates that the date is not in the future' do
      let(:time_input) { TimeInput.new start_time: '08:00', end_time: '08:45', description: 'Lorem', date: 2.days.from_now }

      specify 'should be invalid and contain the proper error message' do
        expect(time_input).to_not be_valid
        expect(time_input.errors[:date]).to include('date can\'t be in the future')
      end
    end
  end
end
