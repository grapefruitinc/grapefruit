class LecturesController < ApplicationController
	def new
  	@lecture = Lecture.new
  end

  def show
  	@lecture = Lecture.find(params[:id])
  end

  def create
  	@lecture = Lecture.new(params[:lecture])
  	if @lecture.save
  		flash[:success] = "Lecture created!"
  		redirect_to @lecture
  	else
  		render 'new'
  end

  def destroy
  	@lecture = @lecture.find(params[:id])
  	@lecture.destroy
  	redirect_to :back
  end
end
