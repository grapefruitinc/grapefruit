class AssignmentsController < ApplicationController

  layout "course"

  before_filter :authenticate_user!, :get_course, :hide_sidebar
  before_filter :get_assignment, only: [:edit, :update, :destroy]

  def index
    @assignments = @course.assignments
  end

  def new
    @assignment = @course.assignments.new
  end

  def edit
    @assign
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

  def update

    authorize! :manage, @course

    if @assignment.update_attributes(assignment_params)
      if params[:documents]
        params[:documents][:document].each { |doc|
          @assignment.documents.create(file: doc)
        }
      end
      flash[:success] = "Assignment saved!"
    end

    render 'edit'

  end

  def destroy
    authorize! :manage, @course
    @assignment.destroy
    flash[:success] = "Assignment deleted!"
    redirect_to course_assignments_path(@course)
  end

  private

  def assignment_params
    params.require(:assignment).permit(:name, :description, :assignment_type_id, :points, :documents)
  end

   def get_assignment
    @assignment = Assignment.find(params[:assignment_id] || params[:id])
    unless @assignment.present?
      flash[:error] = "Invalid assignment!"
      redirect_to root_path
    end
  end

end
