class UserMailer < ApplicationMailer
  default from: ENV['ADMIN_GMAIL_USERNAME']

  def pending_approval(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'Pending Approval From Admin!')
  end
end
