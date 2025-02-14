class PasswordResetMailerPreview < ActionMailer::Preview
    def reset_email
      user = User.first # Replace with a valid user if needed
      token = "fake-reset-token" # Use a sample token for preview
      PasswordResetMailer.with(user: user, token: token).reset_email
    end
  end
  