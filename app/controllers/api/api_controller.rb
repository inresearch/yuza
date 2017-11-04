class Api::ApiController < ActionController::API
  rescue_from StandardError do |exception|
    whitelisted = [ActiveRecord::RecordInvalid, InvalidCredentialError]
    is_displayable = whitelisted.include?(exception.class)
    render json: {
      success: false,
      errors: { base: exception.message },
      displayable_error: is_displayable
    }
  end  

  def auth_by_domain!
    host_params = params.require(:host).permit(:secret)
    host = Host.find_by_secret(host_params[:secret])
  rescue => exception
    render json: {
      success: false,
      errors: { base: exception.message },
      displayable_error: false
    }, status: :unauthorized
  end
end
