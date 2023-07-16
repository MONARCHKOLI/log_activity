class User < ApplicationRecord
  has_one_attached :avatar

  has_one :qr_code, dependent: :destroy
  after_create :create_qr_code

  private

  def create_qr_code
    QrCode.create(user: self)
  end
end
