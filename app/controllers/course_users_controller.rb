class CourseUsersController < ApplicationController
  before_filter :get_course

  def create
    @student = User.find(params[:user_id])

    unless @course.students.include?(@student)
      @course.add_student(@student)

      redirect_to course_path(@course) if !@course.edited_by?(current_user)
    end
  end

  def destroy
    @student = User.find(params[:user_id] || params[:id])
    @course.remove_student(@student)
    if current_user == @student
      flash[:success] = "You left #{@course.name}."
      redirect_to courses_path and return
    end
    flash[:success] = "You removed #{@student.name} from the course."
    redirect_to course_people_path(@course)
  end
end
