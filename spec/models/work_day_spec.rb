require 'rails_helper'

describe WorkDay do
  context 'fields' do
    it { is_expected.to respond_to(:duration) }
    it { is_expected.to respond_to(:date) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:duration) }
  end

  context 'assotiations' do
    it { is_expected.to have_many(:work_sessions) }
    it { is_expected.to belong_to(:user) }
  end
end
