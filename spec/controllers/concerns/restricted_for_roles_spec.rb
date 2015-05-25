require 'rails_helper'

describe 'DummyAdminController' do
  controller do
    include RestrictedForRoles

    restrict_for_roles :admin

    def index
      render text: 'hi'
    end
  end


  let(:failure_path){new_user_session_path}

  specify 'redirect guest user' do
    get :index
    expect(response).to redirect_to(failure_path)
  end

  specify 'redirect non admin users' do
    sign_in create(:user)
    get :index
    expect(response).to redirect_to(failure_path)
  end

  specify 'let in the admin user' do
    sign_in create(:admin)
    get :index
    expect(response.status).to eq(200)
  end
end
