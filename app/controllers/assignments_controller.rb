class AssignmentsController < ApplicationController

  layout "course"

  before_filter :authenticate_user!, :get_course, :hide_sidebar
  before_filter :get_assignment, only: [:edit, :show, :update, :destroy]

  def index
    @assignments = @course.assignments.order("updated_at DESC")
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
      process_multiple_documents
      flash[:success] = "The assignment was created!"
      redirect_to course_assignments_path(@course)
    else
      render 'new'
    end
  end

  def update

    authorize! :manage, @course

    if @assignment.update_attributes(assignment_params)
      process_multiple_documents
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

  def process_multiple_documents
    if params[:documents]
      params[:documents][:document].each { |doc|
        @assignment.documents.create(file: doc)
      }
    end
  end

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
