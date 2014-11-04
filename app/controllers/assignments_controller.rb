class AssignmentsController < ApplicationController

  layout "course", only: [:index]

  before_filter :authenticate_user!, :get_course, :hide_sidebar

  def index
  end

end
