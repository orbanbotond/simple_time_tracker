RSpec.shared_examples '500' do
  specify 'returns 500' do
    api_call params, developer_header
    expect(response.status).to eq(500)
  end
end
RSpec.shared_examples '404' do
  specify 'returns 404' do
    api_call params, developer_header
    expect(response.status).to eq(404)
  end
end
RSpec.shared_examples '403' do
  specify 'returns 403' do
    api_call params, developer_header
    expect(response.status).to eq(403)
  end
end
RSpec.shared_examples '401' do
  specify 'returns 401' do
    api_call params, developer_header
    expect(response.status).to eq(401)
  end
end
RSpec.shared_examples '400' do
  specify 'returns 400' do
    api_call params, developer_header
    expect(response.status).to eq(400)
  end
end
RSpec.shared_examples '200' do
  specify 'returns 200' do
    api_call params, developer_header
    expect(response.status).to eq(200)
  end
end
RSpec.shared_examples '201' do
  specify 'returns 201' do
    api_call params, developer_header
    expect(response.status).to eq(201)
  end
end
RSpec.shared_examples 'json result' do
  specify 'returns JSON' do
    api_call params, developer_header
    expect { JSON.parse(response.body) }.not_to raise_error
  end
end
RSpec.shared_examples 'auditable created' do
#TODO
end
RSpec.shared_examples 'contains error code' do |code|
  specify "error code is #{code}" do
    api_call params, developer_header
    json = JSON.parse(response.body)
    expect(json['error_code']).to eq(code)
  end
end
RSpec.shared_examples 'contains error msg' do |msg|
  specify "error msg is #{msg}" do
    api_call params, developer_header
    json = JSON.parse(response.body)
    expect(json['error_msg']).to eq(msg)
  end
end
