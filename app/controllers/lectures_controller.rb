class LecturesController < ApplicationController
  before_filter :get_course
  before_filter :get_capsule

	def new
  	@lecture = @capsule.lectures.new
  end

  def show
  	@lecture = @capsule.lectures.find(params[:id])
  end

  def create
  	@lecture = @capsule.lectures.new(lecture_params)
  	if @lecture.save
  		flash[:success] = "Lecture created!"
  		redirect_to [@course, @capsule, @lecture]
  	else
  		render 'new'
    end
  end

  def destroy
  	@lecture = @lecture.find(params[:id])
  	@lecture.destroy
  	redirect_to :back
  end

private
  def lecture_params
    params.require(:lecture).permit(:name, :lecture_number)
  end
end
