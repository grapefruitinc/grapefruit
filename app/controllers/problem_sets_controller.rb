class ProblemSetsController < ApplicationController

  before_filter :get_course
  before_filter :get_capsule

  layout "home"

  def new
    @problem_set = @capsule.problem_sets.new
  end

  def show
    @problem_set = @capsule.problem_sets.find(params[:id])
  end

  def create
    @problem_set = @capsule.problem_sets.new(problem_set_params)
    if @problem_set.save
      flash[:success] = "Problem set created!"
      redirect_to [@course, @capsule, @problem_set]
    else
      render 'new'
    end
  end

  def destroy
    @problem_set = @problem_set.find(params[:id])
    @problem_set.destroy
    redirect_to :back
  end

private
  def problem_set_params
    params.require(:problem_set).permit(:name)
  end
end
