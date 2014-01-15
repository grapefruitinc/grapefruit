class DocumentsController < ApplicationController

  before_filter :get_course
  before_filter :authenticate_user!

  layout "home"

  def new
    @document = @course.documents.new
  end

  def create

    @document = @course.documents.new(document_params)

    if @document.save
      flash[:success] = "File added!"
      redirect_to course_path(@course)
    else
      render 'new'
    end

  end

  def destroy
    @document = @course.documents.find(params[:id])
    name = @document[:file]
    @document.destroy
    flash[:success] = "#{name} was deleted!"
    redirect_to course_path(@course)
  end

  private
  def document_params
    params.require(:document).permit(:file, :description)
  end

end
