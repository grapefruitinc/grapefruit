class HomeController < ApplicationController
  
  layout "home"

  def dashboard
    @instructed_courses = current_user.instructed_courses
    @enrolled_courses = current_user.student_courses
  end
end
