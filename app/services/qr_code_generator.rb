# app/services/qr_code_generator.rb

require 'rqrcode'

class QrCodeGenerator
  def self.generate(user)
    qr_code = RQRCode::QRCode.new(user_info_to_string(user))
    qr_code.as_svg
  end

  private

  def self.user_info_to_string(user)
    user_data = "http://localhost:3000/users/#{user.id}"
    # user_data += ", #{user.avatar.service_url}" if user.avatar.attached?
    user_data
  end
end
