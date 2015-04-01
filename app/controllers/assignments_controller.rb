class AssignmentsController < ApplicationController

  layout "course"

  before_filter :authenticate_user!, :get_course, :hide_sidebar
  before_filter :get_assignment, only: [:edit, :show, :update, :destroy]

  def index
    if can? :manage, @course
      @assignments = @course.assignments.order("updated_at DESC")
    else
      @assignments = @course.assignments.where('reveal_day < ?', DateTime.now).order("due_day ASC")
    end
  end

  def new
    @assignment = @course.assignments.new
  end

  def edit
  end

  def show
    @submissions = @assignment.submissions.where(user_id: current_user.id).order("created_at DESC")
    @grade = @assignment.grades.where(user_id: current_user.id).last
  end

  def create
    authorize! :manage, @course

    @assignment = @course.assignments.new(assignment_params)
    process_multiple_documents(@assignment)

    if @assignment.save
      send_assignment_email(@course, @assignment)
      flash[:success] = "The assignment was created!"
      redirect_to course_assignments_path(@course)
    else
      render 'new'
    end
  end

  def update
    authorize! :manage, @course

    if @assignment.update_attributes(assignment_params)
      process_multiple_documents(@assignment)
      flash[:success] = "Assignment saved!"
    end

    redirect_to edit_course_assignment_path(@course, @assignment)
  end

  def destroy
    authorize! :manage, @course
    @assignment.destroy
    flash[:success] = "Assignment deleted!"
    redirect_to course_assignments_path(@course)
  end

private

  def assignment_params
    params.require(:assignment).permit(:name, :description, :assignment_type_id, :points, :documents, :reveal_day, :due_day)
  end

  def send_assignment_email(course, assignment)
    if params[:send_email]
      course.students.each do |student|
        UserMailer.new_assignment(student, course, assignment).deliver_later
      end
    end
  end

end
