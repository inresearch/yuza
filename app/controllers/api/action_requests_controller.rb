class Api::ActionRequestsController < Api::ApiController
  def create
    create_params = params.require(:action_request).permit(:request, host: [:domain])
    host = Host.find_by_domain(create_params[:host][:domain])
    action_request = host.action_requests.new(request: create_params[:request])
    action_request.save!
    render json: Serializer::ActionRequestSerializer.new(action_request).to_h
  end
end
