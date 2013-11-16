class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_course
  	@course = Course.find(params[:course_id] || params[:id])
  	unless @course.present?
  		flash[:error] = "Invalid course!"
  		redirect_to root_path
  	end
  end

  def get_capsule
    @capsule = Capsule.find(params[:capsule_id] || params[:id])
    unless @capsule.present?
      flash[:error] = "Invalid capsule!"
      redirect_to root_path
    end
  end

end
