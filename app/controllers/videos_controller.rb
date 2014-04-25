class VideosController < ApplicationController

  require 'youtube_it'
  require 'yaml'

  before_filter :authenticate_user!
  before_filter :get_course
  before_filter :get_capsule
  before_filter :get_all_course_capsules
  before_filter :get_lecture
  before_filter :get_video, only: [:show, :destroy]

  layout "course"

  def new
    @video = @lecture.videos.new
  end

  def create
    @video = @lecture.videos.new(video_params)

    if @video.file
      @video.file = video_params[:file].tempfile.path
      client = getYoutubeClient
      upload = client.video_upload(File.open(@video.file),
                                   title: @video.title,
                                   description: @video.description,
                                   category: 'People',
                                   keywords: %w[rensselaer grapefruit lecture video])

      @video.youtube_id = upload.video_id.split(':')[-1]

      if @video.save
        flash[:success] = "Video created!"
        redirect_to [@course, @capsule, @lecture]
      else
        flash[:error] = "Something went wrong..."
        render :new
      end
    elsif @video.mediasite_url
      if @video.save
        flash[:success] = "Mediasite video added!"
        redirect_to [@course, @capsule, @lecture]
      else
        flash[:error] = "Something went wrong..."
        render :new
      end
    else
      flash[:error] = "Please select a video to upload!"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @video.update_attributes(video_params)
      flash[:success] = "Video updated!"
      redirect_to [@course, @capsule, @lecture]
    else
      render :edit
    end
  end

  def destroy
    @video.destroy
    redirect_to :back
  end

private

  def video_params
    params.require(:video).permit(:title, :description, :file, :mediasite_url)
  end

  def get_video
    @video = @lecture.videos.find(params[:video_id] || params[:id])
    unless @video.present?
      flash[:error] = "Invalid video!"
      redirect_to [@course, @capsule, @lecture]
    end
  end

  def getYoutubeClient
    YouTubeIt::Client.new(username: Settings.youtube.username,
                          password: Settings.youtube.password,
                          dev_key: Settings.youtube.dev_key)
  end

end
