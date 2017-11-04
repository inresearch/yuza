require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let(:params) { {user: user_attributes, password: password_attributes} }
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

    it 'can update password when password presents' do
      expect(User.first.valid_password?('Aloha12345', app: 'pageok')).to eq false
      put :update, params: {password: {password: 'Aloha12345', app: 'pageok'}, id: User.first.id}
      expect(parsed_body[:success]).to eq true
      expect(User.first.valid_password?('Aloha12345', app: 'pageok')).to eq true
    end

    it 'can create password when instance is missing' do
      User.first.passwords.destroy_all
      expect(User.first.passwords).to be_empty
      put :update, params: {password: {password: 'Aloha12345', app: 'pageok'}, id: User.first.id}
      expect(User.first.passwords).to_not be_empty
      expect(User.first.valid_password?('Aloha12345', app: 'pageok')).to eq true
    end

    context 'invalid data' do
      it 'fails gracefully when password too short' do
        put :update, params: {password: {password: 'a', app: 'pageok'}, id: User.first.id}
        expect(parsed_body).to eq({
          success: false,
          errors: {base: "Validation failed: Password is too short (minimum is 8 characters)"},
          displayable_error: true
        })
      end # fail

      it 'fails gracefully when app not present' do
        put :update, params: {password: {password: 'Password02'}, id: User.first.id}
        expect(parsed_body).to include({
          success: false,
        })
      end
    end # invalid data
  end
end
