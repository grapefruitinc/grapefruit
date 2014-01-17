class CapsulesController < ApplicationController
  
  before_filter :get_course
  before_filter :authenticate_user!

  layout "home"

	def new
  	@capsule = @course.capsules.new
    authorize! :create, @capsule
  end

  def show
  	@capsule = @course.capsules.find(params[:id])
    @lectures = @capsule.lectures.order("created_at ASC")
    @problem_sets = @capsule.problem_sets.order("created_at ASC")
    @lectures.build
    @problem_sets.build
  end

  def create
  	@capsule = @course.capsules.new(capsule_params)
    authorize! :create, @capsule
  	if @capsule.save
  		flash[:success] = "Capsule created!"
  		redirect_to [@course, @capsule]
  	else
  		render 'new'
    end
  end

  def destroy
  	@capsule = @capsule.find(params[:id])
    authorize! :delete, @capsule
  	@capsule.destroy
  	redirect_to :back
  end

private
  def capsule_params
    params.require(:capsule).permit(:name)
  end
end