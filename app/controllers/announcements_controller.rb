class AnnouncementsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_announcement, only: [:edit, :update, :destroy]
  before_filter :get_course

  layout "course"

  def new_to_class
    authorize! :manage, @course
  end

  def send_to_class
    authorize! :manage, @course
    UserMailer.to_class(current_user, @course, params[:subject], params[:message]).deliver_now
    flash[:success] = "Email sent!"
    redirect_to course_announcements_path(@course)
  end

  def new
    @announcement = @course.announcements.new
    authorize! :manage, @course
  end

  def create
    @announcement = @course.announcements.new(announcement_params)
    authorize! :manage, @course

    if @announcement.save
      flash[:success] = "Announcement created!"
      if(params[:send_email])
        UserMailer.to_class(current_user, @course, @announcement.title, @announcement.content).deliver_now
      end
      redirect_to course_announcements_path(@course)
    else
      render "new"
    end
  end

  def index
    authorize! :read, @course
    @announcements = @course.announcements.order("created_at DESC").paginate(page: params[:page])
  end

  def edit
    authorize! :manage, @course
  end

  def update
    authorize! :manage, @course

    if @announcement.update_attributes(announcement_params)
      flash[:success] = "Announcement updated!"
      redirect_to course_announcements_path(@course)
    else
      render "edit"
    end
  end

  def destroy
    authorize! :manage, @course
    @announcement.destroy
    flash[:success] = "Announcement deleted!"
    redirect_to [@course, @announcement]
  end

private

  def get_announcement
    @announcement = Announcement.find(params[:announcement_id] || params[:id])
    unless @announcement.present?
      flash[:error] = "Invalid announcement!"
      redirect_to root_path
    end
  end

  def announcement_params
    params.require(:announcement).permit(:title, :content)
  end

end
