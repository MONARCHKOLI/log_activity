class QrCodesController < ApplicationController
  def show
    @qrcode = QrCode.find(params[:id])
    respond_to do |format|
      format.svg { render inline: @qrcode.svg_data }
    end
  end
end
