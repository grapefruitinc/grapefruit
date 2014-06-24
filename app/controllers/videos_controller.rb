class VideosController < ApplicationController

  require 'youtube_it'
  require 'yaml'

  before_filter :authenticate_user!
  before_filter :get_course
  before_filter :get_capsule
  before_filter :get_all_course_capsules
  before_filter :get_lecture
  before_filter :get_video, only: [:show, :destroy]

  layout "course", except: [:show]

  def new
    @video = @lecture.videos.new
  end

  def create

    @video = @lecture.videos.new(video_params)

    if @video.file # is a YouTube video
      
      @video.file = video_params[:file].tempfile.path
      client = getYoutubeClient
      upload = client.video_upload(File.open(@video.file),
                                   title: @video.title,
                                   description: @video.description,
                                   category: 'Education',
                                   keywords: %w[rensselaer grapefruit lecture video],
                                   list: 'denied')

      @video.youtube_id = upload.video_id.split(':')[-1]

      if @video.save
        flash[:success] = "YouTube video created!"
        redirect_to [@course, @capsule, @lecture] and return
      end
      
    elsif @video.mediasite_url # is a mediasite video
      
      if @video.save
        flash[:success] = "Mediasite video added!"
        redirect_to [@course, @capsule, @lecture] and return
      end
      
    else
      @video.save
    end
    
    render :new
    
  end

  def show
    render layout: "home"
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
