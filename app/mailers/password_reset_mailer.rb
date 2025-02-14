class PasswordResetMailer < ApplicationMailer
    def send_reset_email
      @user = params[:user]  # Fetch the user
      mail(to: @user.email, subject: "Reset Your Password")  # Send email
    end
    def reset_email
       @user = params[:user]
       @token = params[:token]
       mail(to: @user.email, subject: "Reset Your Password")
    end
  end
  