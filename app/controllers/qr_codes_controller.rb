class QrCodesController < ApplicationController
  def show
    @qrcode = QrCode.find(params[:id])
    respond_to do |format|
      format.svg { render template: 'qrcodes/qrcode.svg.erb' }
    end
  end
end
