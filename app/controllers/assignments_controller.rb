class AssignmentsController < ApplicationController

  layout "course", only: [:index, :assignment_types]

  before_filter :get_course, :hide_sidebar

  def index
  end

  def assignment_types
  end

end
