class API::V1::ApplicationController < ApplicationController

  skip_before_filter :check_full_profile

private

  def authenticate_user_from_token!
    user_email = request.headers["user-email"].presence
    puts params
    if user_email.nil?
      user_email = params[:authentication_data][:email] if params[:authentication_data]
    end

    if user_email.nil?
      render json: { success: false, message: "Email is missing." }, status: 401
      puts "Authentication failed: User email is nil"
      return
    end

    @user = user_email && User.find_by_email(user_email)

    if @user && Devise.secure_compare(@user.authentication_token, request.headers["authentication-token"] || params[:authentication_data][:authentication_token])
      sign_in @user, store: false
    else
      puts "Authentication failed: email or authentication_token is invalid"
      render json: { success: false, message: "Email or authentication_token is invalid." }, status: 401
    end
  end

end
