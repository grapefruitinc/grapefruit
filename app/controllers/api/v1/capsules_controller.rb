class API::V1::CapsulesController < API::V1::ApplicationController

  before_filter :authenticate_user_from_token!
  before_filter :get_course
  before_filter :get_capsules, only: :index
  before_filter :get_capsule, only: :show

  def index
  end

  def show
  end

end
