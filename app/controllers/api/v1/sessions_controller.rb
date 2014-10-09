class API::V1::SessionsController < API::V1::ApplicationController

  before_filter :authenticate_user_from_token!, only: [:destroy]
  before_filter :ensure_params_exist, only: [:create]

  def create
    @user = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt(:wrong_email) unless @user

    if @user.valid_password?(params[:user][:password])
      sign_in(:user, @user)
      @user.new_authentication_token!
      return
    else
      invalid_login_attempt(:wrong_password)
    end
  end

  def destroy
    @user.reset_authentication_token!
    render json: { success: true }
  end

protected

  def ensure_params_exist
    return unless params[:user].blank?
    render json: { success: false, message: "missing user parameter" }, status: 400
  end

  def invalid_login_attempt(error = nil)
    if error == :wrong_email
      render json: { success: false, message: "Incorrect email" }, status: 401
    elsif error == :wrong_password
      render json: { success: false, message: "Incorrect password" }, status: 401
    else
      render json: { success: false, message: "Something went wrong please try again" }, status: 401
    end
  end

end
