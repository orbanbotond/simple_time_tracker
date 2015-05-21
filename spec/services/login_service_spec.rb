require 'rails_helper'

describe 'LoginService' do
  let(:subject) { LoginService.new email, pwd }

  context 'invalid params' do
    let!(:user) { create :user }

    context 'invalid email' do
      let(:email) { 'invalid@email.com' }
      let(:pwd) { user.password }
      specify 'returns nil' do
        expect(subject.execute).to be_nil
      end
    end

    context 'invalid password' do
      let(:email) { user.email }
      let(:pwd) { 'invalid' }
      specify 'returns nil' do
        expect(subject.execute).to be_nil
      end
    end
  end

  context 'valid params' do
    let!(:user) { create :user }
    let(:email) { user.email }
    let(:pwd) { user.password }

    specify 'it returns a valid token' do
      expect(subject.execute).to eq(user.authentication_tokens.valid.first)
    end
  end
end
