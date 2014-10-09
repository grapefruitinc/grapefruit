class API::V1::UsersController < API::V1::ApplicationController

  before_filter :authenticate_user_from_token!, only: [:update]

  def create
    @user = User.new(create_user_params)

    unless @user.save
      warden.custom_failure!
      render json: @user.errors, status: 400
    end
  end

  def update
    # A lot of this is pulled from Devise
    current_password = params[:user].delete(:current_password)

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    end

    if @user.valid_password?(current_password)
      unless @user.update_attributes(edit_user_params)
        warden.custom_failure!
        render json: @user.errors, status: 400
      end
    else
      @user.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      render json: @user.errors, status: 400
    end
  end

private

  def create_user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :name)
  end

  def edit_user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :current_password, :name)
  end

end
