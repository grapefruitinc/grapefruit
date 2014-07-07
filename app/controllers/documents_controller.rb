class DocumentsController < ApplicationController

  before_filter :get_owners
  before_filter :get_container
  before_filter :authenticate_user!

  layout "course"

  def new
    @document = @container.documents.new
    authorize! :create, @document
  end

  def create

    @document = @container.documents.new(document_params)

    authorize! :create, @document
    
    if @document.save
      flash[:success] = "File added!"
      redirect_to @redirect
    else
      render 'new'
    end

  end

  def destroy
    @document = Document.find(params[:id])
    authorize! :delete, @document
    name = @document[:file]
    # TODO: these should be changed to the correct hash to reveal on redirect
    if @document.lecture
      redirect = course_capsule_lecture_path(@document.lecture.capsule.course, @document.lecture.capsule, @document.lecture)
    elsif @document.capsule
      redirect = course_capsule_path(@document.capsule.course, @document.capsule)
    else
      redirect = course_path(@document.course)
    end
    redirect = course_manage_path(@document.course)
    @document.destroy
    flash[:success] = "#{name} was deleted!"
    redirect_to redirect
  end

  private
  def get_owners
    if params[:course_id]
       get_course
     end
    if params[:capsule_id]
      get_capsule
    end
    if params[:lecture_id]
      get_lecture
    end
  end

  private
  def get_container
    # TODO: these should be changed to the correct hash to reveal on redirect 
    if @lecture
      @container = @lecture
      @redirect = course_capsule_lecture_path(@course, @capsule, @lecture)
    elsif @capsule
      @container = @capsule
      @redirect = course_capsule_path(@course, @capsule)
    elsif @course
      @container = @course
      @redirect = course_path(@course)
    end
    @redirect = course_manage_path(@course)
  end

private

  def document_params
    params.require(:document).permit(:file, :description)
  end

end
