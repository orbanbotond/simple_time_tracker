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

    context 'validates against the overlaps' do
      let(:work_day) { create :work_day }
      let(:subject) { TimeInput.new start_time: 5.minutes.ago, end_time: 2.minutes.ago, work_day: work_day }
      let(:manager) { WorkSessionManager.new work_day.user, subject }

      before do
        manager.save
      end

      it_behaves_like 'overlapping times'
    end

    context 'validates that the start_time is before the end_time' do
      let(:time_input) { TimeInput.new start_time: '08:00', end_time: '07:59', description: 'Lorem', date: '25/05/2015' }
      let(:the_object) { time_input }

      it_behaves_like 'the start_time is before the end_time'
    end

    context 'validates that the end_time is not in the future' do
      let(:time_input) { TimeInput.new start_time: '08:00', end_time: 2.minutes.from_now, description: 'Lorem', date: Time.zone.now }
      let(:the_object) { time_input }

      it_behaves_like 'end_time is not in the future'
    end

    context 'validates that the date is not in the future' do
      let(:time_input) { TimeInput.new start_time: '08:00', end_time: '08:45', description: 'Lorem', date: 2.days.from_now }
      let(:the_object) { time_input }

      it_behaves_like 'date can not be in the future'
    end
  end
end
