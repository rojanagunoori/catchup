# app/controllers/users_controller.rb

class UsersController < ApplicationController
  def new
    @user = User.new
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
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

