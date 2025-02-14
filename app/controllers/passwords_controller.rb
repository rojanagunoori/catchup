class PasswordsController < ApplicationController
    def send_reset_email
      user = User.find_by(email: params[:email])
      if user
        ActionMailer::Base.mail(
          from: "your-email@gmail.com",
          to: user.email,
          subject: "Password Reset Instructions",
          body: "Click the link to reset your password: http://localhost:3000/reset/#{user.reset_token}"
        ).deliver_now
  
        render json: { message: "Password reset email sent successfully!" }
      else
        render json: { error: "User not found" }, status: 404
      end
    end
  end
  