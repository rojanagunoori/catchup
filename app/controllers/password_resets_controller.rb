﻿# app/controllers/password_resets_controller.rb
class PasswordResetsController < ApplicationController
    def new
        render json: { message: "Password reset request received" } if request.format.json?
    end

    def create
      user = User.find_by(email: params[:email])
  
      if user
        user.generate_password_reset_token!  # Ensure this method exists in User model
        #PasswordResetMailer.with(user: user).send_reset_email.deliver_now
        PasswordResetMailer.with(user: user, token: user.reset_password_token).reset_email.deliver_now
        flash[:notice] = "Password reset instructions sent to your email."
        redirect_to login_path
      else
        flash[:alert] = "Email not found."
        render :new
      end
    end
  
    def create1
      @user = User.find_by(email: params[:email])
      if @user
        # Here you would generate a token and send an email
        redirect_to login_path, notice: "Password reset instructions have been sent to your email."
      else
        flash.now[:alert] = "Email not found"
        render :new
      end
    end
  
    def edit
      # This action would verify the token from the email link
    end
  
    def update
      @user = User.find_by(email: params[:email])
      if @user&.update(password: params[:password], password_confirmation: params[:password_confirmation])
        redirect_to login_path, notice: "Password updated successfully"
      else
        flash.now[:alert] = "Password update failed"
        render :edit
      end
    end
  end
  

