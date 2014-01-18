class VideoTextsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_course
  before_filter :get_capsule
  before_filter :get_lecture
  before_filter :get_video

  def show
    @video_text = @video.video_texts.find(params[:id])
  end

  def new
    @video_text = @video.video_texts.new
  end

  def create
    @video_text = @video.video_texts.new(video_text_params)
    if @video_text.save
      flash[:success] = "Accompany content added!"
      redirect_to [@course, @capsule, @lecture, @video]
    else
      redirect_to(request.fullpath)
    end
  end

  def destroy
    @video_text = @video.video_texts.find(params[:id])
    @video_text.destroy
    redirect_to :back
  end

private
  def video_text_params
    params.require(:video_text).permit(:content, :time)
  end
end
