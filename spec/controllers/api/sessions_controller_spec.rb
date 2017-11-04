require "rails_helper"

describe Api::SessionsController, type: :controller do
  let(:host) { create_host }
  let(:user) { create_user }
  before {
    create_password(user, password_attributes)
  }

  context 'creating session' do
    let(:params) {{
      session: {
        user: {
          email: user.email,
          password: 'Password01',
          app: 'pageok'
        },
        validity_minutes: 30
      },
      host: {secret: host.secret}
    }}

    describe 'POST #create' do
      it 'can create the session when given correct credential' do
        expect(Session.count).to eq 0
        post :create, params: params
        expect(Session.count).to eq 1

        session = Session.first
        expect(session.user).to eq user
        expect(session.expiry_time > 28.minutes.from_now).to be true
        expect(session.ip).to_not be_blank
        expect(session.invalid?).to be false
      end

      it 'raises Invalid credential error when incorrect credential given' do
        params[:session][:user][:password] = 'INVPWDHAHA'
        post :create, params: params
        expect(parsed_body[:errors][:base]).to eq "Invalid credential"
      end
    end # POST create
  end # creating session

  context 'revoking session' do
    let(:session) { create_session(user) }
    let(:params) { {code: session.code, host: {secret: host.secret}} }

    describe 'DELETE #revoke' do
      it 'can invalidate a session' do
        expect(session.invalid?).to be false
        delete :revoke, params: params
        session.reload
        expect(session.invalid?).to be true
        expect(parsed_body[:data][:invalid]).to be true
      end # invalidate
    end # DELETE #revoke
  end # revoking session

  describe 'GET #show' do
    let(:session) { create_session(user) }
    it 'display the record in JSON format' do
      get :show, params: {code: session.code, host: {secret: host.secret}}
      expect(parsed_body).to eq Serializer::SessionSerializer.new(session).to_h
      expect(parsed_body[:data][:user][:id]).to eq session.user_id
    end
  end # GET #show
end # SessionsController
