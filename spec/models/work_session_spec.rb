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

  context 'saving' do
    let(:start_time) { Time.parse('02:20') }
    let(:end_time) { Time.parse('03:40') }
    let(:date) { Date.parse('2014-05-18') }
    let(:work_session) { build :work_session, start_time: start_time, end_time: end_time, date: date }
    # specify 'sets the correct date for start_time and end_time' do
    #   work_session.save
    #   work_session.reload
    #   expect(work_session.start_time.year).to eq(date.year)
    #   expect(work_session.start_time.month).to eq(date.month)
    #   expect(work_session.end_time.year).to eq(date.year)
    #   expect(work_session.end_time.month).to eq(date.month)
    # end
  end
end
