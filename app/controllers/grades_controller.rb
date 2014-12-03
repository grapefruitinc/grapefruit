class GradesController < ApplicationController

  layout "course"

  before_filter :authenticate_user!, :get_course, :get_assignment, :auth, :hide_sidebar
  before_filter :get_grade, only: [:destroy]

  def index
    @submissions_available = @assignment.submissions.where(updated_at: @assignment.submissions.select("max(updated_at)").group(:user_id)).order("updated_at desc")
  end

  def show
  end

  def create
    authorize! :manage, @course
    @assignment = Assignment.find(params[:assignment_id])
    @assignment.grades.where(user_id: params[:user_id]).destroy_all
    @grade = @assignment.grades.new(user_id: params[:user_id], comments: params[:comments], points: params[:points])
    if @grade.valid?
      @grade.save
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
