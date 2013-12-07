class VideosController < ApplicationController

  require 'youtube_it'

  before_filter :authenticate_user!
  before_filter :get_course
  before_filter :get_capsule
  before_filter :get_lecture

  layout "home"

  def show
    @video = @lecture.videos.find(params[:id])
  end

  def new
    @video = @lecture.videos.new
  end

  def create
    @video = @lecture.videos.new(video_params)
    if @video.save
      # client = YouTubeIt::Client.new(:dev_key => "AIzaSyDGt4yhelYivEYFHhb_Al8HB2t3aDylq1k")
      # client.video_upload("http://media.railscasts.com/assets/episodes/videos/412-fast-rails-commands.mp4", :title => "test",:description => 'some description', :category => 'People',:keywords => %w[cool blah test])
      flash[:success] = "Video created!"
      redirect_to [@course, @capsule, @lecture]
    else
      redirect_to root_path
    end
  end

  def destroy
    @video = @lecture.videos.find(params[:id])
    @video.destroy
    redirect_to :back
  end

private
  def video_params
    params.require(:video).permit(:title, :description, :file)
  end
end
