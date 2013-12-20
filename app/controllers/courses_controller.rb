class CoursesController < ApplicationController
  
  before_filter :authenticate_user!

  layout "home"
  
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    ### Should change created_at to a more user-determined statistic ###
    @capsules = @course.capsules.order("created_at DESC")
    @capsules.build

    @documents = @course.documents

    @course_user = @course.course_user(current_user)
    unless @course_user.present?
      @course_user = CourseUser.new
    end
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.instructed_courses.build(course_params)
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
