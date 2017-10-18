require "rails_helper"

describe SessionsController, type: :controller do
  let(:user) { create_user }
  before {
    create_password(user, password_attributes)
  }

  context 'creating session' do
    let(:params) {
      {
        session: {
          user: {
            email: user.email,
            password: 'Password01',
            app: 'pageok'
          },
          validity_minutes: 30
        }
      }
    }

    describe 'POST #create' do
      it 'can create the session' do
        expect(Session.count).to eq 0
        post :create, params: params
        expect(Session.count).to eq 1

        session = Session.first
        expect(session.user).to eq user
        expect(session.expiry_time > 28.minutes.from_now).to be true
      end
    end # POST create
  end # creating session
end # SessionsController
