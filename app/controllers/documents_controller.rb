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
      uploader = DocumentUploader.new
      uploader.store!(@document.file)

      flash[:success] = "File added!"
      redirect_to course_path(@course)
    else
      render 'new'
    end

  end

  def show
  end

  def destroy
  end

  private
  def document_params
    params.fetch(:file, {})
  end

end
