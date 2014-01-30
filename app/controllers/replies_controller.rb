class RepliesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_topic, only: [:show, :create]
  before_filter :get_course, only: [:show, :create]

  def create
    @reply = current_user.replies.new(params.require(:reply).permit(:body))
    @reply.course = @course
    @reply.topic = @topic
    if @reply.valid?
      @topic.add_reply(@reply)
      flash[:success] = "Message posted!"
      pages = @topic.replies.paginate(page: 1, per_page: 10)
      page = pages.total_pages
      redirect_to course_topic_path(@course, @topic) + "?page=#{page}#reply-#{@reply.id}"
    else
      flash[:error] = "Please enter a message."
      redirect_to course_topic_path(@course, @topic) + "#reply"
    end
  end

end
