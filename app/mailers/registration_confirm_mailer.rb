class RegistrationConfirmMailer < ApplicationMailer
  def notification_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('mailer.subject'))
  end
end
