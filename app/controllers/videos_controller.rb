class VideosController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_course
  before_filter :get_capsule
  before_filter :get_lecture

  def show
    @video = @lecture.videos.find(params[:id])
  end

  def new
    @video = @lecture.videos.new
  end

  def create
    @video = @lecture.videos.new(video_params)
    if @video.save
      flash[:success] = "Video created!"
      redirect_to [@course, @capsule, @lecture]
    else
      redirect_to(request.fullpath)
    end
  end

  def destroy
    @video = @lecture.videos.find(params[:id])
    @video.destroy
    redirect_to :back
  end

private
  def video_params
    params.require(:video).permit(:title, :description)
  end
end
