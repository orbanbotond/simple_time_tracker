require 'rails_helper'

describe '/api/work_session' do
  let(:api_key) { create :api_key }
  let(:developer_header) { { 'Authorization' => api_key.token } }

  describe 'GET /work_sessions' do
    let!(:authentication_token) { create :authentication_token }
    let(:user) { authentication_token.user }
    let(:date_start) { Date.parse '02/03/2015' }
    let(:date_end) { Date.parse '03/03/2015' }
    let(:original_params) { { token: authentication_token.token, from: date_start, to: date_end } }
    let(:params) { original_params }

    def api_call *params
      get '/api/work_sessions', *params
    end

    it_behaves_like 'restricted for developers'

    context 'invalid params' do
      it_behaves_like 'unauthenticated'
      it_behaves_like 'auditable created'
    end

    context 'valid params' do
      let(:filter_low) { date_start }
      let(:filter_high) { date_end }
      let!(:work_day_0) { create :work_day, date: (filter_low - 1.days), user: user }
      let!(:work_day_1) { create :work_day, date: filter_low, user: user }
      let!(:work_day_2) { create :work_day, date: filter_high, user: user }
      let!(:work_day_3) { create :work_day, date: (filter_high + 1.days), user: user }
      let!(:work_session_1) { create :work_session, work_day: work_day_0 }
      let!(:work_session_2) { create :work_session, work_day: work_day_1 }
      let!(:work_session_3) { create :work_session, work_day: work_day_2 }
      let!(:work_session_4) { create :work_session, work_day: work_day_3 }

      it_behaves_like '200'
      it_behaves_like 'json result'

      context 'unfiltered' do
        specify 'returns all work_days' do
          api_call params.except(:to, :from), developer_header
          parsed_json = JSON.parse(response.body)
          expect(parsed_json.size).to eq(4)
        end
      end

      context 'filtered' do
        specify 'returns only the filtered work_days' do
          api_call params, developer_header
          parsed_json = JSON.parse(response.body)
          expect(parsed_json.size).to eq(2)
        end
      end
    end
  end

  describe 'POST /work_sessions' do
    let!(:authentication_token) { create :authentication_token }
    let(:user) { authentication_token.user }
    let(:date) { '02/03/2015' }
    let(:time_start) { '08:14' }
    let(:time_end) { '08:39' }
    let(:description) { 'Implementing the Time Reporting App' }
    let(:original_params) { { token: authentication_token.token, date: date, start_time: time_start, end_time: time_end, description: description } }
    let(:params) { original_params }

    def api_call *params
      post '/api/work_sessions', *params
    end

    it_behaves_like 'restricted for developers'

    context 'invalid params' do
      context 'date is missing' do
        let(:params) { original_params.except(:date) }

        it_behaves_like '400'
        it_behaves_like 'json result'
        it_behaves_like 'auditable created'
        it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
        it_behaves_like 'contains error msg', 'date is missing'
      end

      context 'description is missing' do
        let(:params) { original_params.except(:description) }

        it_behaves_like '400'
        it_behaves_like 'json result'
        it_behaves_like 'auditable created'
        it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
        it_behaves_like 'contains error msg', 'description is missing'
      end

      context 'stat time is missing' do
        let(:params) { original_params.except(:start_time) }

        it_behaves_like '400'
        it_behaves_like 'json result'
        it_behaves_like 'auditable created'
        it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
        it_behaves_like 'contains error msg', 'start_time is missing'
      end

      context 'end time is missing' do
        let(:params) { original_params.except(:end_time) }

        it_behaves_like '400'
        it_behaves_like 'json result'
        it_behaves_like 'auditable created'
        it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
        it_behaves_like 'contains error msg', 'end_time is missing'
      end
    end

    context 'valid params' do
      it_behaves_like '201'
      it_behaves_like 'json result'

      specify 'creates a work_session' do
        expect do
          api_call params, developer_header
        end.to change { WorkSession.count }.by(1)
        expect(user.work_days.last.work_sessions.count).to eq(1)
      end
      specify 'the work session belongs to the user' do
        api_call params, developer_header        
        expect(WorkSession.last.user).to eq(user)
      end
    end
  end

  describe 'DELETE /work_sessions/:id' do
    let!(:authentication_token) { create :authentication_token }
    let(:user) { authentication_token.user }
    let(:work_day) { create :work_day, user: user }
    let(:work_session) { create :work_session, work_day: work_day }
    let(:original_params) { { token: authentication_token.token, id: work_session.id } }
    let(:params) { original_params }
    let(:work_session_id) { params[:id] }

    def api_call *params
      delete "/api/work_sessions/#{work_session_id}", *params
    end

    it_behaves_like 'restricted for developers'

    context 'invalid params' do
      context 'token is missing' do
        it_behaves_like 'unauthenticated'
      end

      context 'id belongs to someone elses work_session' do
        let(:another_user) { create :user }
        let(:another_work_day) { create :work_day, date: 1.day.ago, user: another_user }
        let(:another_work_session) { create :work_session, work_day: another_work_day }
        let(:params) { original_params.merge(id: another_work_session.id) }

        it_behaves_like '401'
        it_behaves_like 'json result'
        it_behaves_like 'auditable created'
        it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
        it_behaves_like 'contains error msg', 'not enough privileges'
      end
    end

    context 'valid params' do
      it_behaves_like '200'
      it_behaves_like 'json result'

      specify 'removes a work_session' do
        params
        expect do
          api_call params, developer_header
        end.to change { WorkSession.count }.by(-1)
        expect(user.work_days.last.work_sessions.count).to eq(0)
      end
    end
  end
end
