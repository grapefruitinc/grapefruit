class AssignmentsController < ApplicationController

  layout "course"

  before_filter :authenticate_user!, :get_course, :hide_sidebar

  def index
    @assignments = @course.assignments
  end

  def new
    @assignment = @course.assignments.new
    @types = @course.assignment_types
  end

  def create
  end

end
