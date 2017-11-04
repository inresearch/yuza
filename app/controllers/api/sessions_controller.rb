class Api::SessionsController < Api::ApiController
  before_action :auth_by_domain!

  def create
    create_params = params.require(:session).permit(
      :validity_minutes,
      user: [:email, :password, :app]
    )
    user_params = create_params[:user]

    u = User.email(user_params[:email]).first!
    is_valid = u.valid_password?(user_params[:password], app: user_params[:app])
    s = Session.new(
      app: user_params[:app],
      user: u,
      expiry_time: create_params[:validity_minutes].to_f.minutes.from_now,
      ip: request.remote_ip
    )

    if is_valid
      begin
        s.save!
      rescue => e
        Raven.extra_context(user: u.attributes)
        Raven.extra_context(app: user_params[:app])
        Raven.capture_exception(e)
        raise e
      end
    else
      fail InvalidCredentialError, "Invalid credential"
    end # is_valid

    render json: Serializer::SessionSerializer.new(s).to_h
  end # create

  def revoke
    code = params[:code]
    s = Session.where(code: code).first!
    s.revoke!
    render json: Serializer::SessionSerializer.new(s).to_h
  end

  def show
    code = params[:code]
    s = Session.where(code: code).first!
    render json: Serializer::SessionSerializer.new(s).to_h
  end	
end
