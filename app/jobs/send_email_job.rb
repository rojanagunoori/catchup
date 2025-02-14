class SendEmailJob < ApplicationJob
    queue_as :default
  
    def perform(user_email)
      ActionMailer::Base.mail(
        from: "your-email@gmail.com",
        to: user_email,
        subject: "Password Reset Instructions",
        body: "Click the link to reset your password: http://localhost:3000/reset-password"
      ).deliver_now
    end
  end
  