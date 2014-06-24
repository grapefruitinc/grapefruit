class AdminController < ApplicationController
  
  layout "guest"
  
  before_filter :check_admin
  
  def become
    
    if request.post?
      sign_in(:user, User.find(params[:user_id]), { :bypass => true })
      redirect_to root_url
    end
    
  end
  
  private
  
  def check_admin
    if !admin_user_signed_in?
      redirect_to root_url
    end
  end
  
end
