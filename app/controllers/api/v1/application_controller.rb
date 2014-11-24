class API::V1::ApplicationController < ApplicationController

  skip_before_filter :check_full_profile

private

  def authenticate_user_from_token!
    user_email = request.headers["user-email"] ||
      user_email = params.fetch(:authentication_data, {}).fetch(:email, {})

    token = request.headers["authentication-token"] ||
      params.fetch(:authentication_data, {}).fetch(:authentication_token, {})

    if user_email.blank?
      render json: { success: false, message: "Missing user-email" }, status: 401
      puts "Authentication failed: user-email is nil"
      return
    end

    if user_email.blank?
      render json: { success: false, message: "Missing authentication token" }, status: 401
      puts "Authentication failed: authentication-token is nil"
      return
    end

    @user = user_email && User.find_by_email(user_email)
    correct_token = Devise.secure_compare(@user.authentication_token, token)

    if @user && correct_token
      sign_in @user, store: false
    else
      puts "Authentication failed: email or authentication_token is invalid"
      render json: { success: false, message: "Email or authentication_token is invalid." }, status: 401
    end
  end

  def get_course
    @course = Course.find(params[:course_id] || params[:id])

    unless @course.present?
      flash[:error] = "Invalid course!"
      redirect_to root_path
    else
      @capsules = @course.capsules
    end
  end

  def get_capsule
    @capsule = Capsule.find(params[:capsule_id] || params[:id])

    unless @capsule.present?
      flash[:error] = "Invalid capsule!"
      redirect_to root_path
    end
  end

  def get_capsules
    @capsules = @course.capsules.order("created_at DESC")
  end

  def get_lecture
    @lecture = Lecture.find(params[:lecture_id] || params[:id])

    unless @lecture.present?
      flash[:error] = "Invalid lecture!"
      redirect_to root_path
    end
  end

end
