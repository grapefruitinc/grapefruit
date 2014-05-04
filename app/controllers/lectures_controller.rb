class LecturesController < ApplicationController

  before_filter :get_course
  before_filter :get_capsule
  before_filter :get_all_course_capsules, only: [:new, :show, :edit]
  before_filter :get_lecture, only: [:show, :edit, :update, :toggle_live, :destroy]
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

  def toggle_live
    authorize! :update, @lecture
    @lecture.toggle(:live)
    @lecture.save
    redirect_to [@course, @capsule, @lecture]
  end

  def destroy
    authorize! :destroy, @lecture
  	@lecture.destroy
  	redirect_to :back
  end

private

  def get_lecture
    @lecture = @capsule.lectures.find(params[:lecture_id] || params[:id])
    @live_button = (@lecture.live) ? 'End Lecture' : 'Make Lecture Live';
  end

  def lecture_params
    params.require(:lecture).permit(:name, :description, :lecture_number,
                                    :mediasite_url, :live)
  end

end
