class AssignmentsController < ApplicationController

  layout "course"

  before_filter :authenticate_user!, :get_course, :hide_sidebar

  def index
    @assignments = @course.assignments
  end

  def new
    @assignment = @course.assignments.new
  end

  def create

    authorize! :manage, @course

    @assignment = @course.assignments.new(assignment_params)
    
    if @assignment.valid?
      @assignment.save
      if params[:documents]
        params[:documents].each { |doc|
          @assignment.documents.create(document: doc)
        }
      end
      flash[:success] = "The assignment was created!"
      redirect_to course_assignments_path(@course)
    else
      render 'new'
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:name, :description, :assignment_type_id, :points, :documents)
  end

end
