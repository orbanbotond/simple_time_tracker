require 'rails_helper'

describe 'WorkSessionPolicy' do
  let(:user) { work_session.work_day.user }
  let(:work_session) { create :work_session }
  let(:policy) { WorkSessionPolicy.new user, record }

  context 'create? action' do
    let(:record) do
      work_session
    end

    it 'authorizes' do
      expect(policy.create?).to be_truthy
    end
  end

  context 'update? action' do
    let(:record) do
      work_session
    end

    it 'authorizes' do
      expect(policy.create?).to be_truthy
    end
  end

  context 'show? action' do
    let(:record) do
      work_session
    end

    it 'authorizes' do
      expect(policy.show?).to be_truthy
    end
  end

  context 'destroy? action' do
    let(:record) do
      work_session
    end

    it 'authorizes' do
      expect(policy.show?).to be_truthy
    end
  end
end
