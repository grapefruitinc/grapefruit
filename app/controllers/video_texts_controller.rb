class VideoTextsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_course
  before_filter :get_capsule
  before_filter :get_all_course_capsules
  before_filter :get_lecture
  before_filter :get_video
  before_filter :get_video_text, only: [:update, :destroy]

  layout "course"

  def new
    @video_text = @video.video_texts.new
  end

  def create
    @video_text = @video.video_texts.new(video_text_params)

    if @video_text.save
      msg = { status: :success, msg: "Video annotation saved!" }
      # flash[:success] = "Video annotation added!"
      # redirect_to [@course, @capsule, @lecture]
    else
      msg = { status: :error, msg: "Failed to save!" }
      # redirect_to(request.fullpath)
    end

    respond_to do |format|
      format.json { render json: msg }
    end
  end

  def index
    @video.video_texts.new
  end

  def update
    if @video_text.update_attributes(video_text_params)
      msg = { status: :success, msg: "Video annotation saved!" }
      # redirect_to [@course, @capsule, @lecture]
    else
      msg = { status: :error, msg: "Failed to save!" }
      # render :edit
    end

    respond_to do |format|
      format.json { render json: msg }
    end
  end

  def destroy
    if @video_text.destroy
      msg = { status: :success, msg: "Video annotation deleted!" }
    else
      msg = { status: :error, msg: "Failed to delete!" }
    end

    # redirect_to :back
    respond_to do |format|
      format.json { render json: msg }
    end
  end

private

  def video_text_params
    params.require(:video_text).permit(:content, :time)
  end

  def get_video_text
    @video_text = @video.video_texts.find(params[:video_text_id] || params[:id])
    unless @video_text.present?
      flash[:error] = "Invalid video annotation!"
      redirect_to [@course, @capsule, @lecture]
    end
  end

end
