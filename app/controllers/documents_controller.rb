class DocumentsController < ApplicationController

  before_filter :get_owners
  before_filter :get_container
  before_filter :authenticate_user!

  layout "home"

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
    @document = @container.documents.find(params[:id])
    authorize! :delete, @document
    name = @document[:file]
    @document.destroy
    flash[:success] = "#{name} was deleted!"
    redirect_to @redirect
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
  end

  private
  def document_params
    params.require(:document).permit(:file, :description)
  end

end
