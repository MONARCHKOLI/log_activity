class RegistrationConfirmMailer < ApplicationMailer
  def notification_email(user)
    @user = user
    mail(to: @user.email, subject: 'You have registered succesfully....')
  end
end
