require 'rails_helper'

describe WorkSession do
  context 'fields' do
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:start_time) }
    it { is_expected.to respond_to(:end_time) }
    it { is_expected.to respond_to(:date) }
  end

  context 'assotiations' do
   it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
    it { is_expected.to validate_presence_of(:date) }
  end

  context "methods" do
    let(:start_time) { Time.parse('02:20') }
    let(:end_time) { Time.parse('03:40') }
    let(:date) { Date.parse('2014-05-18') }
    let(:work_session) { build :work_session, start_time: start_time, end_time: end_time, date: date }
    context "#start_time" do
      specify 'returns the year month day set in date' do
        expect(work_session.start_time.year).to eq(date.year)
        expect(work_session.start_time.month).to eq(date.month)
        expect(work_session.start_time.day).to eq(date.day)
      end
    end
    context "#end_time" do
      specify 'returns the year month day set in date' do
        expect(work_session.end_time.year).to eq(date.year)
        expect(work_session.end_time.month).to eq(date.month)
        expect(work_session.end_time.day).to eq(date.day)
      end
    end
    context "#in_preferred_hour?" do
      it { is_expected.to respond_to(:in_preferred_hour?) }
      let!(:user) { create :user}
      let!(:preferred_hour_1) { create :preferred_working_hour, hour: 0, user: user }
      let!(:preferred_hour_2) { create :preferred_working_hour, hour: 4, user: user }
      let(:work_session_1) { create :work_session, start_time: Time.parse('00:22'), end_time: Time.parse('01:45'), user: user }
      let(:work_session_2) { create :work_session, start_time: Time.parse('03:22'), end_time: Time.parse('04:45'), user: user }
      let(:work_session_3) { create :work_session, start_time: Time.parse('04:22'), end_time: Time.parse('04:28'), user: user }
      let(:work_session_4) { create :work_session, start_time: Time.parse('03:22'), end_time: Time.parse('05:28'), user: user }
      let(:work_session_5) { create :work_session, start_time: Time.parse('05:22'), end_time: Time.parse('06:28'), user: user }

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
