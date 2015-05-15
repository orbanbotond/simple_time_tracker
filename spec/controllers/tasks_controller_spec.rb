require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  describe 'GET #index' do
    context 'unsigned' do
      it 'returns redirects' do
        get :index
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context 'signed' do
      let(:user) { create :user }
      it "returns http success" do
        sign_in(user)
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

end
