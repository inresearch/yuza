class UsersController < ApplicationController
  def show
    u = User.find(params[:id])
    render json: UserSerializer.new(u).to_h
  end

  def create
    u = User.new(user_params)
    User.transaction do
      u.save
      password_ins = u.init_new_password(password_params)
      password_ins.save
      raise ActiveRecord::Rollback if u.id.blank? || password_ins.id.blank?
    end
    render json: UserSerializer.new(u).to_h
  end

  def update
    u = User.find(params[:id])

    if params[:user] && !params[:user].empty?
      u.name = user_params[:name] if user_params[:name]
      u.phone = user_params[:phone] if user_params[:phone]
    end

    if params[:password] && !params[:password].empty?
      password_ins = u.passwords.app(password_params[:app]).first
      password_ins = u.passwords.new(app: password_params[:app]) unless password_ins
      password_ins.password = password_params[:password] if password_params[:password]
      password_ins.save!
    end

    u.save
    render json: UserSerializer.new(u).to_h
  end

  def user_params
    params.require(:user).permit(:id, :name, :email, :phone, :password)
  end

  def password_params
    params.require(:password).permit(:app, :password)
  end
end
