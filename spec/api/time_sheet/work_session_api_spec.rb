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

  end
end
