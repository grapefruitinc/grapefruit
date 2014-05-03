class CourseUsersController < ApplicationController
  before_filter :course_joinable, only: [:create, :destroy]

  def create
    unless @course.students.include?(@student)
      @course.add_student(@student)

      respond_to do |format|
        format.html { redirect_to course_path(@course) } if @course.instructor != current_user # Joining course
        format.js
      end
    end
  end

  def destroy
    @course.remove_student(@student)
    redirect_to course_path(@course)    
  end

private
  def course_joinable
    @course = Course.find(params[:course_id] || params[:id])
    @user = User.find(params[:course_user][:user_id])
    @student = User.find(params[:course_user][:user_id])
  end

end
