class PasswordResetMailer < ApplicationMailer
    def send_reset_email
      @user = params[:user]
      mail(to: @user.email, subject: "Reset Your Password")
    end
  end
  