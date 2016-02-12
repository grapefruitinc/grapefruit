class HomeController < ApplicationController

  layout "home"

  def dashboard
    @student_courses = current_user.student_courses
    @instructor_courses = current_user.instructor_courses
    @assistant_courses = current_user.assistant_courses
  end

  def management_state
    if params.has_key? :open_panels
      if params[:open_panels] == "get"
        render text: cookies[:management_state] and return
      else
        cookies[:management_state] = params[:open_panels]
        render text: "success" and return
      end
    end
    render text: "error"
  end

end
