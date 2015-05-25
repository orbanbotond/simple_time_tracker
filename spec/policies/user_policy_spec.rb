require 'rails_helper'

describe 'UserPolicy' do
  let(:user) { create :admin }
  let(:user_as_object) { build_stubbed :user }
  let(:policy) { UserPolicy.new user, record }

  context 'create? action' do
    let(:record) do
      user_as_object
    end
    it 'authorizes' do
      expect(policy.create?).to be_truthy
    end
  end

  context 'update? action' do
    let(:record) do
      user_as_object
    end
    it 'authorizes' do
      expect(policy.create?).to be_truthy
    end
  end

  context 'show? action' do
    let(:record) do
      user_as_object
    end
    it 'authorizes' do
      expect(policy.show?).to be_truthy
    end
  end
end
