class UsersController < ApplicationController
  def signin
  end

  def signup
  end

  def process_signin
  end

  def process_signup
    user_params = params.require(:user).permit(:name, :email, :password, :repeat_password)
  end
end
