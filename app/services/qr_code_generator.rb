require 'rqrcode'

class QrCodeGenerator
  def self.generate_qr_code(user_info)
    qr_code = RQRCode::QRCode.new(user_info)
    qr_code.as_svg
  end
end