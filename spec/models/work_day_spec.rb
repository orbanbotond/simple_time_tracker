require 'rails_helper'

describe WorkDay do
  context 'fields' do
    it { is_expected.to respond_to(:duration) }
    it { is_expected.to respond_to(:date) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:duration) }
    it { is_expected.to validate_presence_of(:date) }

    context 'validates that the date is not in the future' do
      let(:work_day) { WorkDay.new date: 2.days.from_now }
      let(:the_object) { work_day }

      it_behaves_like 'date can not be in the future'
    end

    context 'validates that there is not another saved day belonging to the same user with the current date' do
      let!(:work_day) { create :work_day, date: 2.days.ago }
      let!(:work_day_) { create :work_day, date: 1.days.ago }

      context 'negative case' do
        context 'for an new record' do
          let(:subject) { build :work_day, date: 2.days.ago, user: work_day.user }

          it { is_expected.to_not be_valid }

          specify 'proper error message is added for the date field' do
            subject.valid?
            expect(subject.errors[:date]).to include('there is a work day on that date belonging to the same user')
          end
        end

        context 'validating an already saved object' do
          let(:subject) { create :work_day, date: 2.days.ago, user: work_day_.user }

          specify 'proper error message is added for the date field' do
            subject.date = 1.days.ago
            expect(subject).to_not be_valid
            expect(subject.errors[:date]).to include('there is a work day on that date belonging to the same user')
          end
        end
      end

      context 'positive case' do
        context 'validating as new object' do
          let(:subject) { build :work_day, date: 2.days.ago }
          it { is_expected.to be_valid }
        end
        context 'validating as saved object' do
          let(:subject) { create :work_day, date: 2.days.ago }
          it { is_expected.to be_valid }
        end
      end
    end
  end

  context 'assotiations' do
    it { is_expected.to have_many(:work_sessions) }
    it { is_expected.to belong_to(:user) }
  end

  context 'duration is calculation' do
    let!(:work_day) { create :work_day }
    let!(:work_session) { create :work_session, work_day: work_day}

    specify 'saving the work session adjusts the work_days duration' do
      work_session2 = build :work_session, work_day: work_day, start_time: 12.minutes.ago, end_time: 11.minutes.ago
      work_session2.save
      work_session3 = build :work_session, work_day: work_day, start_time: 6.minutes.ago, end_time: 5.minutes.ago
      expect do
        work_session3.save
      end.to change { work_day.duration }.by(work_session2.duration)
    end
  end
end
