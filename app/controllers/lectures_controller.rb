class LecturesController < ApplicationController

  before_filter :get_course
  before_filter :get_capsule
  before_filter :get_all_course_capsules, only: [:new, :show, :edit]
  before_filter :get_lecture, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  layout "course"

	def new
  	@lecture = @capsule.lectures.new
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

  def show
    authorize! :show, @lecture
  	@lecture = @capsule.lectures.find(params[:id])
    @capsules = @lecture.capsule.course.capsules

    @videos = @lecture.videos.order("created_at ASC")
    @videos.build

    @documents = @lecture.documents
  end

  def edit
    authorize! :update, @lecture
  end

  def update
    authorize! :update, @lecture
    if @lecture.update_attributes(lecture_params)
      flash[:success] = "Lecture updated!"
      redirect_to [@course, @capsule, @lecture]
    else
      render "edit"
    end
  end

  def destroy
    authorize! :destroy, @lecture
  	@lecture.destroy
  	redirect_to :back
  end

private

  def get_lecture
    @lecture = @capsule.lectures.find(params[:lecture_id] || params[:id])
  end

  def lecture_params
    params.require(:lecture).permit(:name, :lecture_number, :mediasite_url)
  end

end
