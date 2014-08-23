class LecturesController < ApplicationController

  before_filter :get_course
  before_filter :get_capsule
  before_filter :get_all_course_capsules, only: [:new, :show, :edit]
  before_filter :get_lecture, except: [:create, :new]
  before_filter :authenticate_user!

  layout "course"

	def new
  	@lecture = @capsule.lectures.new
  end

  def create
    @lecture = @capsule.lectures.new(lecture_params)
    if @lecture.save
      flash[:success] = "Lecture created!"
      redirect_to course_manage_path(@course)
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
      redirect_to course_manage_path(@course)
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

  def comments
    authorize! :show, @lecture
    @comment = @lecture.comments.new
    render layout: "home"
  end

  def submit_comment
    authorize! :show, @lecture
    comment_params = params.require(:comment).permit(:body)
    @comment = @lecture.comments.new(comment_params)
    @comment.author = current_user
    if not @lecture.live
      render json: {error: true}
    elsif @comment.save
      render json: {success: true}
    else
      render json: {error: true}
    end
  end

  def list_comments
    authorize! :show, @lecture
    render json: @lecture.comments.order('created_at ASC').limit(50)
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
