class UsersController < ApplicationController
  def create
    u = User.new(permitted_params)
    u.save
    render json: UserSerializer.new(u).to_h
  end

  def update
    u = User.find(params[:id])
    u.name = permitted_params[:name] if permitted_params[:name]
    u.phone = permitted_params[:phone] if permitted_params[:phone]
    u.password = permitted_params[:password] if permitted_params[:password]
    u.save
    render json: UserSerializer.new(u).to_h
  end

  def permitted_params
    params.require(:user).permit(:id, :name, :email, :phone, :password)
  end
end
