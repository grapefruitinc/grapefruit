class API::V1::LecturesController < API::V1::ApplicationController

  before_filter :authenticate_user_from_token!
  before_filter :get_course
  before_filter :get_capsule
  before_filter :get_lecture

  def show
  end

end
