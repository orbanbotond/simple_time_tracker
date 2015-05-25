require 'rails_helper'

describe WorkSession do
  context 'fields' do
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:start_time) }
    it { is_expected.to respond_to(:end_time) }
    it { is_expected.to respond_to(:duration) }
    it { is_expected.to respond_to(:user) }
  end

  context 'assotiations' do
   it { is_expected.to belong_to(:work_day) }
  end

  context 'methods' do
    let(:start_time) { Time.parse('02:20') }
    let(:end_time) { Time.parse('03:40') }
    let(:date) { Date.parse('2014-05-18') }
    let(:work_session) { build :work_session, start_time: start_time, end_time: end_time, date: date }

    context "#duration" do
      it { is_expected.to respond_to(:duration) }
      let(:work_session) { create :work_session, start_time: Time.parse('00:22'), end_time: Time.parse('01:45') }
      
      specify 'should be 83 minutes in seconds' do
        expect(work_session.duration).to eq(4980.0)
      end
    end

    context '#in_preferred_hour?' do
      it { is_expected.to respond_to(:in_preferred_hour?) }
      let!(:user) { create :user}
      let!(:work_day) { create :work_day, user: user }
      let!(:preferred_hour_1) { create :preferred_working_hour, hour: 0, user: user }
      let!(:preferred_hour_2) { create :preferred_working_hour, hour: 4, user: user }
      let(:work_session_1) { create :work_session, start_time: Time.parse('00:22'), end_time: Time.parse('01:45'), work_day: work_day }
      let(:work_session_2) { create :work_session, start_time: Time.parse('03:22'), end_time: Time.parse('04:45'), work_day: work_day }
      let(:work_session_3) { create :work_session, start_time: Time.parse('04:22'), end_time: Time.parse('04:28'), work_day: work_day }
      let(:work_session_4) { create :work_session, start_time: Time.parse('03:22'), end_time: Time.parse('05:28'), work_day: work_day }
      let(:work_session_5) { create :work_session, start_time: Time.parse('05:22'), end_time: Time.parse('06:28'), work_day: work_day }

      specify 'the working session started in a preferred hour' do
        expect(work_session_1).to be_in_preferred_hour
      end
      specify 'the working session ended in a preferred hour' do
        expect(work_session_2).to be_in_preferred_hour
      end
      specify 'the working session is in a preferred hour' do
        expect(work_session_3).to be_in_preferred_hour
      end
      specify 'the working session overlaps a preferred hour' do
        expect(work_session_4).to be_in_preferred_hour
      end
      specify 'is not in any preferred hour' do
        expect(work_session_5).to_not be_in_preferred_hour
      end
    end
  end
end
