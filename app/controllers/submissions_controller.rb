class SubmissionsController < ApplicationController

  layout "course"

  before_filter :authenticate_user!, :get_course, :hide_sidebar
  before_filter :get_assignment
  before_filter :get_submission, only: :destroy

  def new
    @submission = @assignment.submissions.new(user_id: current_user.id)
  end

  def create
    @submission = @assignment.submissions.new(submission_params(user_id: current_user.id))
    process_multiple_documents(@submission)

    if @submission.save
      flash[:success] = "You have submitted a response to " + @assignment.name
      redirect_to course_assignment_path(@course, @assignment)
    else
      render 'new'
    end
  end

  def destroy
    @submission.destroy
    flash[:success] = "Submission deleted!"
    redirect_to course_assignment_path(@course, @assignment)
  end

  private

  def submission_params(extra_params = {})
    params.require(:submission).permit(:comments, :documents).merge(extra_params)
  end

end
