class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #allow_browser versions: :modern
  #include Devise::Controllers::Helpers
  #before_action :authenticate_user!
  #before_action :require_user
  before_action :require_user, except: [:new, :create]  # Allow login page access
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    #redirect_to login_path unless logged_in?
    unless logged_in?
      flash[:alert] = "You must be logged in to perform this action."
      redirect_to login_path  # Redirect to your login page
    end
  end

  # Redirect /users/sign_up to home page
  #def after_sign_up_path_for(resource)
   # root_path
  #end
  
end


