class CapsulesController < ApplicationController
  before_filter :get_course

	def new
  	@capsule = @course.capsules.new
  end

  def show
  	@capsule = @course.capsules.find(params[:id])
  end

  def create
  	@capsule = @course.capsules.new(capsule_params)
  	if @capsule.save
  		flash[:success] = "Capsule created!"
  		redirect_to course_capsule_path(@capsule)
  	else
  		render 'new'
    end
  end

  def destroy
  	@capsule = @capsule.find(params[:id])
  	@capsule.destroy
  	redirect_to :back
  end

private
  def capsule_params
    params.require(:capsule).permit(:name)
  end
end