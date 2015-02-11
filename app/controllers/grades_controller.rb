class GradesController < ApplicationController

  layout "course"

  before_filter :authenticate_user!, :get_course, :auth, :hide_sidebar
  before_filter :get_assignment, except: [:gradelist]
  before_filter :get_grade, only: [:destroy]

  def index
    @available_submissions = @assignment.available_submissions
  end

  def gradelist
  end

  def create
    authorize! :manage, @course

    # Clear out old grades
    @assignment = Assignment.find(params[:assignment_id])
    @assignment.grades.where(user_id: params[:user_id]).destroy_all

    @grade = @assignment.grades.new(user_id: params[:user_id], comments: params[:comments], points: params[:points])
    process_multiple_documents(@grade)

    if @grade.save
      render json: @grade.id
    else
      render json: -1
    end
  end

  def destroy
  end

  private

  def auth
    authorize! :manage, @course
  end

  def grade_params(extra_params = {})
    params.permit(:comments, :points, :assignment_id, :user_id).merge(extra_params)
  end

end
