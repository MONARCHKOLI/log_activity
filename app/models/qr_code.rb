# require 'rqrcode'

# class QrCode < ApplicationRecord
#   belongs_to :user
#   before_create :generate_qr_code

#   private

#   def generate_qr_code
#     qr_code = RQRCode::QRCode.new(user_info)
#     svg = qr_code.as_svg(
#       offset: 0,
#       color: '000',
#       shape_rendering: 'crispEdges',
#       module_size: 6,
#       standalone: true
#     )
#     # self.svg_data = svg
#   end

#   def user_info
#     # Customize this method according to your user information structure
#     "#{user.first_name + ' ' + user.last_name}\n#{user.date_of_birth}"
#   end
# end
