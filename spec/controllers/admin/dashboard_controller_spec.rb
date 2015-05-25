require 'rails_helper'

describe Admin::DashboardController do
  context 'class hierarchy' do
    specify {expect(subject).to be_kind_of(Admin::BaseController)}
  end

  context 'index' do
    specify 'should be 200' do
      sign_in create(:admin)
      get :index
      expect(response.status).to eq(200)
    end
  end
end
