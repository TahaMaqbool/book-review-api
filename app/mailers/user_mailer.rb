class UserMailer < ApplicationMailer
  default from: ENV['ADMIN_GMAIL_USERNAME']

  def pending_approval_user(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'Pending Approval From Admin')
  end

  def pending_approval_admin(admin)
    @admin = admin
    @url = 'http://example.com/login'
    mail(to: @admin.email, subject: 'Review Book For Approval')
  end

  def book_approved(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'Book Approved')
  end
end
