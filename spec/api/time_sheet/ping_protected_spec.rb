require 'rails_helper'

describe 'api/ping' do
  describe 'GET /api/ping' do
    let(:api_key) { create :api_key }
    let(:developer_header) { {'Authorization' => api_key.token} }
    let(:params) { {} }

    def api_call *params
      get "/api/ping_dev", *params
    end

    context 'without developer key' do
      it_behaves_like 'restricted for developers'
    end

    context 'with developer key' do
      it_behaves_like '200'
      it_behaves_like 'json result'
    end
  end
end
