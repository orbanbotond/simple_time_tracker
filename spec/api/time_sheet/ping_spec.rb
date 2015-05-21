require 'rails_helper'

describe 'GET /api/ping' do
  def api_call *params
    get '/api/ping'
  end
  let(:params) { {} }
  let(:developer_header) { {} }
  it_behaves_like '200'
  it_behaves_like 'json result'
end
