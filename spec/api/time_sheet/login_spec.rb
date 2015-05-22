require 'rails_helper'

describe '/api/login' do
  let(:api_key) { create :api_key }
  let(:developer_header) { {'Authorization' => api_key.token} }

  describe 'POST /login/forgot_password' do
    let!(:user) { create :user }
    let(:original_params) { { email: user.email} }
    let(:params) { original_params }

    def api_call *params
      post '/api/login/forgot_password', *params
    end

    it_behaves_like 'restricted for developers'

    context 'invalid params' do
      let(:params) { original_params.except(:email) }

      it_behaves_like '400'
      it_behaves_like 'json result'
      it_behaves_like 'auditable created'

      it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
      it_behaves_like 'contains error msg', 'email is missing'
    end

    context 'valid params' do
      it_behaves_like '200'
      it_behaves_like 'json result'
      specify "send a reminder email" do
        api_call params, developer_header
        expect(ActionMailer::Base.deliveries.last.to).to eq([user.email])
      end
    end
  end

  describe '/login' do
    let(:email) { user.email }
    let(:password) { user.password }
    let!(:user) { create :user }
    let(:original_params) { { email: email, password: password } }
    let(:params) { original_params }

    def api_call *params
      post "/api/login", *params
    end

    it_behaves_like 'restricted for developers'

    context 'invalid params' do
      context 'incorrect password' do
        let(:params) { original_params.merge(password: 'invalid') }

        it_behaves_like '401'
        it_behaves_like 'json result'
        it_behaves_like 'auditable created'

        specify "returns an error message" do
          api_call params, developer_header
          parsed_json = JSON.parse(response.body)
          expect(parsed_json['error_msg']).to eq('Bad Authentication Parameters')
        end

        it_behaves_like 'contains error code', ErrorCodes::BAD_AUTHENTICATION_PARAMS
      end

      context "with a non-existent login" do
        let(:params) { original_params.merge(email: 'notreal', password: 'invalid') }
        it_behaves_like '401'
        it_behaves_like 'json result'
        it_behaves_like 'auditable created'

        it_behaves_like 'contains error code', ErrorCodes::BAD_AUTHENTICATION_PARAMS
      end
    end

    context 'valid params' do
      it_behaves_like '200'
      it_behaves_like 'json result'

      specify 'returns the token as part of the response' do
        api_call params, developer_header
        expect(JSON.parse(response.body)['token']).to be_present
      end
    end
  end
end
