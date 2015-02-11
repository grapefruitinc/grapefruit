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
      redirect_to course_manage_path(@document.course)
    else
      render 'new'
    end

  end

  def destroy
    @document = Document.find(params[:id])
    authorize! :delete, @document
    name = @document[:file]
    assignment = @document.assignment ? @document.assignment : nil
    @document.destroy
    flash[:success] = "#{name} was deleted!"
    if assignment
      redirect_to edit_course_assignment_path(assignment.course, assignment)
    else
      redirect_to course_manage_path(@document.course)
    end
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
    elsif @capsule
      @container = @capsule
    elsif @course
      @container = @course
    end
  end

private

  def document_params
    params.require(:document).permit(:file, :description)
  end

end
