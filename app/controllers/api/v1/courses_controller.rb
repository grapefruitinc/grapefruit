class API::V1::CoursesController < API::V1::ApplicationController

  before_filter :authenticate_user_from_token!

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

end
