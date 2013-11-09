class CoursesController < ApplicationController
  def new
  	@course = Course.new
  end

  def show
  	@course = Course.find(params[:id])
  end

  def create
  	@course = Course.new(params[:course])
  	if @course.save
  		flash[:success] = "Course created"
  		redirect_to @course
  	else
  		render 'new'
  end

  def destroy
  	@course = @course.find(params[:id])
  	@course.destroy
  	redirect_to :back
  end
end
