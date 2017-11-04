require "rails_helper"

describe Api::ActionRequestsController, type: :controller do
  let(:host) { create_host }

  describe 'POST #create' do
    let(:params) {{
      action_request: {
        host: {domain: host.domain},
        request: ActionRequest::SIGNUP_REQUEST
      }
    }}

    it 'creates request action' do
      expect(ActionRequest.first).to be_nil
      post :create, params: params
      expect(parsed_body[:success]).to be true
      expect(parsed_body[:errors]).to be_blank
      expect(parsed_body[:data][:host]).to eq 'pageok.com'
      expect(parsed_body[:data][:request]).to eq ActionRequest::SIGNUP_REQUEST
      expect(parsed_body[:data][:id]).to_not be_blank
      expect(ActionRequest.first).to_not be_nil
    end
  end
end
