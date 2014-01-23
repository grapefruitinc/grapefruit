class CoursesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_course, only: [:show, :edit, :update, :destroy]

  layout "home"
  
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

  def index
    @courses = Course.all
    @instructed_courses = current_user.instructed_courses
    @enrolled_courses = current_user.student_courses
  end

  def show
    ### Should change created_at to a more user-determined statistic ###
    @capsules = @course.capsules.order("created_at DESC")
    @capsules.build

    @documents = @course.documents

    @course_user = @course.course_user(current_user)
    unless @course_user.present?
      @course_user = CourseUser.new
    end
  end

  def edit
    authorize! :update, @course
  end

  def update
    authorize! :update, @course
    if @course.update_attributes(course_params)
      flash[:success] = "Course updated!"
      redirect_to course_path(@course)
    else
      render "edit"
    end
  end

  def destroy
    authorize! :destroy, @course
    @course.destroy
    redirect_to :back
  end

private

  def course_params
    params.require(:course).permit(:name)
  end
  
end
