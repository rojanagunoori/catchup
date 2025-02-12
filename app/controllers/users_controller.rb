# app/controllers/users_controller.rb

class UsersController < ApplicationController

  before_action :require_user


  def new
    @user = User.new
  end

  #def show
    #@user = User.find(params[:id])
    #@friends_count = @user.friends.count
    #@user = current_user
    #@thoughts = @user.thoughts.order(created_at: :desc) # Assuming a Thought model exists
  #end

  def show
    @user = current_user || User.find_by(id: params[:id])
  
    if @user.nil?
      redirect_to login_path, alert: "Please log in to view your profile."
      return
    end
  
    @thoughts = @user.thoughts
    @friends_count = @user.friends.count if @user.respond_to?(:friends)
  end
  
  
  

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Signup successful! Please log in."
      redirect_to login_path
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  #def edit
    #@user = User.find(params[:id])
  #end

  def edit
    @user = current_user
    redirect_to root_path, alert: "User not found" if @user.nil?
    #@user = User.find_by(id: params[:id])
    #if @user.nil?
      #Rails.logger.debug "User not found! params[:id]: #{params[:id]}"
      #redirect_to root_path, alert: "User not found"
    #end
  end


  def update
    @user = current_user
    
    if params[:user][:profile_picture].present?
      @user.profile_picture.attach(params[:user][:profile_picture])
    end
  
    if params[:user][:profile_picture_url].present?
      @user.profile_picture_url = params[:user][:profile_picture_url]
    end
  
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile updated successfully"
    else
      Rails.logger.debug "Update failed: #{@user.errors.full_messages.join(', ')}"
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end
  

  def destroy_all_sessions
    session.delete(:user_id)# Remove the user ID from the session
    #current_user.update(authentication_token: nil) # This invalidates all sessions
    reset_session # Clears the current session
    redirect_to login_path, notice: "Logged out from all devices."
  end
  
  
  
  

  private

  def user_params
    allowed_params = [:name, :email, :about, :profile_picture, :profile_picture_url]
    allowed_params += [:password, :password_confirmation] if params[:user][:password].present?
    params.require(:user).permit(allowed_params)

    #params.require(:user).permit(:name, :email, :password, :password_confirmation, :about, :profile_picture, :profile_picture_url)
  end
end


'''# app/controllers/users_controller.rb
class UsersController < ApplicationController
    #before_action :require_user, only: %i[edit update]
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to thoughts_path, notice: "Welcome to Catchup!"
      else
        render :new
      end
    end
  
    def edit
      @user = current_user
    end
  
    def update
      @user = current_user
      if @user.update(user_params)
        redirect_to account_path, notice: "Profile updated successfully"
      else
        render :edit
      end
    end
  
    private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :about)
    end
  end
 '''

