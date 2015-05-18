require 'rails_helper'

RSpec.describe PreferredWorkingHoursController, type: :controller do

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    let(:user) { create :user }

    it "returns http success" do
      sign_in(user)

      get :update
      expect(response).to have_http_status(:success)
    end
  end

end
