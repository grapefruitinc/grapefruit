class API::V1::PasswordsController < Devise::PasswordsController

  before_filter :check_email, only: [:create]
  # before_filter :check_password_token_and_code, only: [:update]

  def create
    # super
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    unless successfully_sent?(resource)
      render json: { success: false, message: "Something went wrong, please try again." }, status: 400
      return
    end
    # super
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      @user.new_authentication_token!

      sign_in(:user, @user)
    else
      warden.custom_failure!
      render json: resource.errors, status: 400
      # render json: { success: false, message: "Password was not updated, please try again." }, status: 400
    end
  end

private

  def check_email
    @user = User.find_by_email(params[:user][:email])

    if @user.nil?
      render json: { success: false, message: "Email does not exist in our records, please try again." }, status: 400
    end
  end

  def check_password_token_and_code
    @user = User.find_by_reset_password_token(resource_params[:reset_password_token])

    if @user.nil?
      render json: { success: false, message: "Invalid password reset token." }, status: 400
    else
      check_password_token_expiration
    end
  end

  # Only allow recent password recoveries to work
  def check_password_token_expiration
    if @user.reset_password_sent_at < 12.hours.ago
      @user.forgot_password_code = nil
      @user.save validate: false
      render json: { success: false, message: "Password reset has expired. Please try again." }, status: 400
    end
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :reset_password_token)
  end

end