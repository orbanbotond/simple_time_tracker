require 'rails_helper'

describe '/api/user_preferences' do
  let(:api_key) { create :api_key }
  let(:developer_header) { { 'Authorization' => api_key.token } }
  let!(:authentication_token) { create :authentication_token }
  let(:user) { authentication_token.user }
  let!(:preferred_working_hours_1) { create :preferred_working_hour, user: user, hour: 1 }
  let!(:preferred_working_hours_2) { create :preferred_working_hour, user: user, hour: 3 }

  describe 'GET /user_preferences' do
    let(:original_params) { { token: authentication_token.token } }
    let(:params) { original_params }

    def api_call *params
      get '/api/preferences', *params
    end

    it_behaves_like 'restricted for developers'

    context 'valid params' do
      it_behaves_like '200'
      it_behaves_like 'json result'

      specify 'returns the preferences' do
        api_call params, developer_header
        expect(JSON.parse(response.body)).to eq([1,3])
      end
    end
  end

  describe 'POST /api/user_preferences' do
    let(:original_params) { { token: authentication_token.token, hours: "[3,4,5,6]" } }
    let(:params) { original_params }

    def api_call *params
      post '/api/preferences', *params
    end

    it_behaves_like 'restricted for developers'

    context 'invalid params' do
      let(:params) { original_params.except(:hours) }

      it_behaves_like 'auditable created'
      it_behaves_like '400'
      it_behaves_like 'json result'
      it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
      it_behaves_like 'contains error msg', 'hours is missing'
    end

    context 'valid params' do
      it_behaves_like '201'
      it_behaves_like 'json result'

      specify 'returns the preferences' do
        api_call params, developer_header
        expect(JSON.parse(response.body)).to eq([3,4,5,6])
      end

      specify 'saves the preferences' do
        api_call params, developer_header
        expect(user.preferred_working_hours.pluck(:hour)).to eq([3,4,5,6])
      end
    end
  end
end
