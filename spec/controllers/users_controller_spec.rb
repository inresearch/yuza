require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:params) { {user: user_attributes } }
  before { params.delete(:id) }
  before { Timecop.freeze(Time.local(2020)) }
  after { Timecop.return }

  describe 'POST #create' do
    it 'can create user data given valid attributes' do
      expect(User.first).to be_nil

      post :create, params: params
      expect(response.content_type).to eq 'application/json'
      expect(parsed_body).to eq({
        success: true,
        errors: {},
        data: {
          id: User.first.id,
          name: "Adam",
          email: "adam@netinmax.com",
          phone: nil,
          created_at: 1577811600.0,
          updated_at: 1577811600.0
        }
      })
    end # can create

    it 'cannot create data when attributes invalid' do
      params[:user].delete(:email)
      expect(User.first).to be_nil

      post :create, params: params
      expect(response.content_type).to eq 'application/json'
      expect(parsed_body[:success]).to eq false
      expect(parsed_body[:errors]).to include(:email)

      expect(User.first).to be_nil
    end
  end # POST #create

  describe 'PUT #update' do
    before { post :create, params: params }

    it 'can update data' do
      expect(User.first.name).to eq 'Adam'
      put :update, params: {user: {name: 'Akira'}, id: User.first.id}
      expect(parsed_body[:success]).to eq true
      expect(User.first.name).to eq 'Akira'
    end

    it 'can update password' do
      expect(User.first.valid_password?('Aloha12345')).to eq false
      put :update, params: {user: {password: 'Aloha12345'}, id: User.first.id}
      expect(parsed_body[:success]).to eq true
      expect(User.first.valid_password?('Aloha12345')).to eq true
    end
  end
end
