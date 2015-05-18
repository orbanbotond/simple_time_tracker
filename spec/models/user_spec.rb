require 'rails_helper'

describe User do

  context 'fields' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:email) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }

    context 'email validation' do
      let(:user) { build :user }
      let(:user_with_invalid_email) { build :user, email: 'invalid.email' }

      specify 'valid email' do
        expect(user).to be_truthy
      end

      specify 'invalid email' do
        expect(user_with_invalid_email.valid?).to be_falsy
        expect(user_with_invalid_email.errors[:email]).to be_present
      end
    end
  end

  context 'assotiations' do
    it { is_expected.to have_many(:work_sessions) }
  end

end
