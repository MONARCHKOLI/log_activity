class User < ApplicationRecord
  has_one_attached :avatar
  after_create :send_notification_email
  after_update :send_notification_email

  private

  def send_notification_email
    RegistrationConfirmMailer.notification_email(self).deliver_now
  end
end
