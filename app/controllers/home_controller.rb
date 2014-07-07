class HomeController < ApplicationController
  
  layout "home"

  def dashboard
    @instructed_courses = current_user.instructed_courses
    @enrolled_courses = current_user.student_courses
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
