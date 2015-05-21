RSpec.shared_examples 'restricted for developers' do
  context 'without developer key' do
    specify "should be an unauthorized call" do
      api_call params
      expect(response.status).to eq(401)
    end
    specify "result is a JSON" do
      api_call params
      expect{ JSON.parse(response.body) }.not_to raise_error
    end
    specify "error code is 1001" do
      api_call params
      json = JSON.parse(response.body)
      expect(json['error_code']).to eq(ErrorCodes::DEVELOPER_KEY_MISSING)
    end
  end
end

RSpec.shared_examples 'unauthenticated' do
  context 'unauthenticated' do
    specify "returns 401 without token" do
      api_call params.except(:token), developer_header
      expect(response.status).to eq(401)
    end
    specify "result is a JSON" do
      api_call params.except(:token), developer_header
      expect{ JSON.parse(response.body) }.not_to raise_error
    end
  end
end

RSpec.shared_examples "checkable against authentication and developer access" do
  it_behaves_like 'restricted for developers'
  it_behaves_like 'unauthenticated'
end
