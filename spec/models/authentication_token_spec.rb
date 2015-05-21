require 'rails_helper'

describe AuthenticationToken do
  context 'fields' do
    it { is_expected.to respond_to(:token) }
    it { is_expected.to respond_to(:expires_at) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:token) }
  end

  context 'assotiations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'scopes' do
    context 'valid' do
      let!(:authentication_token_valid_1) { create :authentication_token, expires_at: nil }
      let!(:authentication_token_valid_2) { create :authentication_token }
      let!(:authentication_token_invalid) { create :authentication_token, expires_at: 2.days.ago }

      specify 'returns only the two valid tokens' do
        expect(AuthenticationToken.valid.count).to eq(2)
      end
    end
  end

  context 'singleton methods' do
    context ".generate" do
      let!(:user) { create :user }
      specify 'the token belongs to the specified user' do
        token = AuthenticationToken.generate(user)
        expect(token.user).to eq(user)
      end
      specify 'the expiration date by default is two months' do
        token = AuthenticationToken.generate(user)
        expect(token.expires_at).to be_within(5.seconds).of(Time.zone.now + 60.days)
      end
      specify 'the expiration date can be set' do
        expiration_intervall = 1.month
        token = AuthenticationToken.generate(user, expiration_intervall)
        expect(token.expires_at).to be_within(5.seconds).of(Time.zone.now + expiration_intervall)
      end
    end
  end
end
