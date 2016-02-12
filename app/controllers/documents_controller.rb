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
    @document.destroy
    flash[:success] = "#{name} was deleted!"
    if @document.assignment
      redirect_to edit_course_assignment_path(@document.assignment.course, @document.assignment)
    elsif @document.grade
      redirect_to course_assignment_grades_path(@document.grade.assignment.course, @document.grade.assignment)
    elsif @document.lecture
      redirect_to course_manage_path(@document.lecture.capsule.course)
    elsif @document.capsule
      redirect_to course_manage_path(@document.capsule.course)
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
      @redirect = course_manage_path(@lecture.capsule.course)
    elsif @capsule
      @container = @capsule
      @redirect = course_manage_path(@capsule.course)
    elsif @course
      @container = @course
      @redirect = course_manage_path(@course)
    end
  end

private

  def document_params
    params.require(:document).permit(:file, :description)
  end

end
