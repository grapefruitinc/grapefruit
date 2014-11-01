class AssignmentsController < ApplicationController

  layout "course", only: [:index, :assignment_types]

  before_filter :authenticate_user!, :get_course, :hide_sidebar

  def index
  end

  def assignment_types

    @current_types = @course.assignment_types

    if request.xhr?
      render json: @current_types
    end

  end

end
