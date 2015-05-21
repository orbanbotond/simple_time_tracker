require 'rails_helper'

describe Entities::UserWithTokenEntity do
  describe 'fields' do
    subject(:subject) { Entities::UserWithTokenEntity }
    specify { expect(subject).to represent(:email)}
    specify { expect(subject).to represent(:name)}

    let!(:token) { create :authentication_token }
    specify 'presents the first available token' do
      json = Entities::UserWithTokenEntity.new(token.user).as_json
      expect(json[:token]).to be_present
    end
  end
end
