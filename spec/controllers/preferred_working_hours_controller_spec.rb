require 'rails_helper'

describe PreferredWorkingHoursController do

  describe "GET #edit" do
    context 'unsigned' do
      it 'returns redirects' do
        get :edit
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe "GET #update" do
    context "logged in" do
      let(:user) { create :user }

      it "returns http success" do
        sign_in(user)

        get :update
        expect(response).to have_http_status(:success)
      end
    end

    context 'unsigned' do
      it 'returns redirects' do
        get :edit
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
