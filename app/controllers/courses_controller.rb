class CoursesController < ApplicationController

  layout "home"

  before_filter :authenticate_user!
  
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    ### Should chnage created_at to a more user-determined statistic ###
    @capsules = @course.capsules.order("created_at DESC")
    @capsules.build
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Course created!"
      redirect_to @course
    else
      render 'new'
    end
  end

  def destroy
    @course = @course.find(params[:id])
    @course.destroy
    redirect_to :back
  end

private
  def course_params
    params.require(:course).permit(:name)
  end
end
