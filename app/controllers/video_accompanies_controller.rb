class VideoAccompaniesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_course
  before_filter :get_capsule
  before_filter :get_lecture
  before_filter :get_video

  def show
    @video_accompany = @video.video_accompanies.find(params[:id])
  end

  def create
    @video_accompany = @video.video_accompanies.new(video_accompany_params)
    if @video_accompany.save
      flash[:success] = "Accompany content added!"
      redirect_to [@course, @capsule, @lecture]
    else
      redirect_to(request.fullpath)
    end
  end

  def destroy
    @video_accompany = @video.video_accompanies.find(params[:id])
    @video_accompany.destroy
    redirect_to :back
  end

private
  def video_accompany_params
    params.require(:video_accompany).permit(:content, :time)
  end
end
