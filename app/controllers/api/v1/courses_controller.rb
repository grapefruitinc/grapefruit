class API::V1::CoursesController < API::V1::ApplicationController

  before_filter :authenticate_user_from_token!
  before_filter :get_course, only: :show

  def index
    @courses = Course.all
  end

  def show
  end

end
