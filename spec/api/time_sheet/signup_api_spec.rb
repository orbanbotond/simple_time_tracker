require 'rails_helper'

describe '/api/sign_up' do
  let(:api_key) { create :api_key }
  let(:developer_header) { {'Authorization' => api_key.token} }

  describe 'POST /api/sign_up' do
    let!(:user) { create :user }
    let(:original_params) { { name: 'John Smith', email: 'new_user@email.com', password: 'password', password_confirmation: 'password' } }
    let(:params) { original_params }

    def api_call *params
      post '/api/sign_up', *params
    end

    it_behaves_like 'restricted for developers'

    context 'invalid params' do
      context 'missing parameters' do
        context 'name missing' do
          let(:params) { original_params.except(:name) }

          it_behaves_like '400'
          it_behaves_like 'json result'
          it_behaves_like 'auditable created'

          it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
          it_behaves_like 'contains error msg', 'name is missing'
        end

        context 'email missing' do
          let(:params) { original_params.except(:email) }

          it_behaves_like '400'
          it_behaves_like 'json result'
          it_behaves_like 'auditable created'

          it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
          it_behaves_like 'contains error msg', 'email is missing'
        end

        context 'password missing' do
          let(:params) { original_params.except(:password) }

          it_behaves_like '400'
          it_behaves_like 'json result'
          it_behaves_like 'auditable created'

          it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
          it_behaves_like 'contains error msg', 'password is missing'
        end

        context 'password_confirmation missing' do
          let(:params) { original_params.except(:password_confirmation) }

          it_behaves_like '400'
          it_behaves_like 'json result'
          it_behaves_like 'auditable created'

          it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
          it_behaves_like 'contains error msg', 'password_confirmation is missing'
        end
      end

      context 'wrong parameters' do
        context 'email is already allocated' do
          let(:params) { original_params.merge(email: user.email) }

          it_behaves_like '400'
          it_behaves_like 'json result'
          it_behaves_like 'auditable created'

          it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
          it_behaves_like 'contains error msg', 'An Account Using That Email Is Already Present'
        end

        context 'password mismatch' do
          let(:params) { original_params.merge(password: 'psadlasd') }

          it_behaves_like '400'
          it_behaves_like 'json result'
          it_behaves_like 'auditable created'

          it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
          it_behaves_like 'contains error msg', ["Password confirmation doesn't match Password"]
        end

        context 'password_confirmation mismatch' do
          let(:params) { original_params.merge(password_confirmation: 'asdasdsa') }

          it_behaves_like '400'
          it_behaves_like 'json result'
          it_behaves_like 'auditable created'

          it_behaves_like 'contains error code', ErrorCodes::BAD_PARAMS
          it_behaves_like 'contains error msg', ["Password confirmation doesn't match Password"]
        end
      end
    end

    context 'valid params' do
      it_behaves_like '201'
      it_behaves_like 'json result'

      specify 'creates a user' do
        expect do
          api_call params, developer_header
        end.to change { User.count }.by(1)
      end

      specify 'sets the users email' do
        api_call params, developer_header
        expect(User.last.email).to eq(params[:email])
      end

      specify 'sets the users password' do
        api_call params, developer_header
        expect(User.last.valid_password?(params[:password])).to be_truthy
      end

      specify 'creates a token' do
        expect do
          api_call params, developer_header
        end.to change { AuthenticationToken.count }.by(1)
      end

      specify 'the token belongs to the users ...' do
        api_call params, developer_header
        expect(AuthenticationToken.last.user.email).to eq(params[:email])
      end
    end
  end
end
