require 'rails_helper'

describe ApiKey do
  context 'fields' do
    it { is_expected.to respond_to(:token) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:token) }
  end
end
