class ApplicationController < ActionController::API
  rescue_from StandardError do |exception|
    whitelisted = [ActiveRecord::RecordInvalid]
    is_displayable = whitelisted.include?(exception.class)
    render json: {
      succeed: false,
      errors: {base: exception.message},
      displayable_error: is_displayable
    }
  end
end
