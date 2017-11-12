class Api::UsersController < Api::ApiController
  before_action :auth_by_domain!

  def show
    u = User.find(params[:id])
    render json: Serializer::UserSerializer.new(u).to_h
  end

  def create
    u = User.new(user_params)
    u.save
    render json: Serializer::UserSerializer.new(u).to_h
  end

  def update
    u = User.find(params[:id])

    if params[:user] && !params[:user].empty?
      u.name = user_params[:name] if user_params[:name]
    end

    if params[:password] && !params[:password].empty?
      password_ins = u.passwords.app(password_params[:app]).first
      password_ins = u.passwords.new(app: password_params[:app]) unless password_ins
      password_ins.password = password_params[:password] if password_params[:password]
      password_ins.save!
    end

    u.save
    render json: Serializer::UserSerializer.new(u).to_h
  end

  def user_params
    params.require(:user).permit(:id, :name, :email, :password)
  end
end
