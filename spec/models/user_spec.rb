require 'rails_helper'

describe User do

  context 'fields' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:email) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end

end
