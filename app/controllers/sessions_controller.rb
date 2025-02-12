# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]


    def new
      redirect_to thoughts_path if logged_in?
    end

    def create
      user = User.find_by(email: params[:session][:email].downcase) # Correct key
      if user && user.authenticate(params[:session][:password]) # Correct key
        session[:user_id] = user.id
        redirect_to dashboard_path, notice: "Logged in successfully."
        #render json: { message: "Logged in successfully", user_id: user.id }, status: :ok
        #redirect_to root_path, notice: "Logged in successfully"
      else
        #render json: { error: "Invalid email or password" }, status: :unauthorized
        flash.now[:alert] = "Invalid email or password"
        render :new, status: :unauthorized
      end
    end
    

    #def create
      #user = User.find_by(email: params[:email])
      
      #if user
        #puts "User found: #{user.inspect}"  # Debugging
        #if user.authenticate(params[:password])
          #session[:user_id] = user.id
          #redirect_to root_path, notice: "Logged in successfully!"
        #else
          #puts "Password authentication failed!"  # Debugging
          #flash[:alert] = "Invalid email or password. Please try again."
          #render :new, status: :unprocessable_entity
        #end
      #else
        #puts "User not found with email: #{params[:email]}"  # Debugging
        #flash[:alert] = "Invalid email or password. Please try again."
        #render :new, status: :unprocessable_entity
      #end
    #end
    
  
    #def create
      #user = User.find_by(email: params[:email])
      #if user&.authenticate(params[:password])
        #session[:user_id] = user.id
        #redirect_to thoughts_path, notice: "Logged in successfully"
      #else
        #flash.now[:alert] = "Invalid email or password. Please try again."
        #render :new
        #render :new, status: :unprocessable_entity
      #end
    #end
  
    def destroy
        reset_session # Clears the session only for the current browser
        #session[:user_id] = nil
        #log_out
        redirect_to login_path, notice: "Logged out successfully" # Redirects to login page
         #redirect_to login_path, notice: "Logout cancelled"
      #session[:user_id] = nil
      #redirect_to login_path, notice: "Logged out successfully"
    end
  end
  

