require 'rails_helper'

describe WorkSessionsController do
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
        sign_in user
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #new' do
    context 'unsigned' do
      it 'returns redirects' do
        get :new
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context 'signed' do
      let(:user) { create :user }
      it "returns http success" do
        sign_in user
        get :new
        expect(response).to have_http_status(:success)
        expect(assigns[:time_input]).to be_present
      end
    end
  end

  describe 'GET #create' do
    let(:params) { { "time_input"=>{ "description"=>"tralala", "date"=>"2015-01-03", "start_time"=>"12:45", "end_time"=>"13:59" } } }

    context 'unsigned' do
      it 'returns redirects' do
        post :create, params
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context 'signed' do
      let(:user) { create :user }
      it "returns http success" do
        sign_in user
        post :create, params
        expect(response).to redirect_to(work_sessions_path)
        expect(WorkSession.last.user).to be_present
      end
    end
  end
end
