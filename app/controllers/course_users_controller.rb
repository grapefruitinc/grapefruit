class CourseUsersController < ApplicationController
  before_filter :get_course
  before_filter :get_student, only: [:create]
  before_filter :get_student_with_user_id, only: [:destroy]

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
    redirect_to course_students_path(@course)   
  end

private
  def get_student
    @student = User.find(params[:course_user][:user_id])
  end
  def get_student_with_user_id
    @student = User.find(params[:user_id] || params[:id])
  end
end
