class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @qr_code = QrCodeGenerator.generate(@user)
    @qr_code_svg = @qr_code

    respond_to do |format|
      format.html
      format.pdf do
        require 'prawn'
      
        @user_details = [
          { label: "Unique Identity:", value: @user.unique_identity },
          { label: "Name:", value: "#{@user.first_name} #{@user.last_name}" },
          { label: "Date Of Birth:", value: @user.date_of_birth },
          { label: "Gender:", value: @user.gender },
          { label: "Age:", value: @user.age },
          { label: "Registered at:", value: @user.created_at.to_date }
        ]
      
        pdf = Prawn::Document.new
      
        if @user.avatar.attached?
          image_path = ActiveStorage::Blob.service.send(:path_for, @user.avatar.key)
          pdf.image(image_path, width: 100, height: 100)
        else
          pdf.text "No Avatar Available"
        end
      
        svg_document = Nokogiri::XML::Document.parse(@qr_code_svg)
        svg_fragment = svg_document.root
        pdf.svg svg_fragment.to_s, at: [50, 400], width: 200, height: 200
      
        pdf.text "User Details", size: 18, style: :bold
        pdf.move_down 20
        # Define the table data for the user details
        table_data = @user_details.map { |detail| [detail[:label], detail[:value]] }

        # Create the table with the user details
        table_data.each do |row|
          pdf.draw_text row[0], at: [pdf.bounds.left + 20, pdf.cursor]
          pdf.draw_text row[1], at: [pdf.bounds.left + 220, pdf.cursor]
          pdf.move_down 20
        end
        # @user_details.each do |detail| 
        #   pdf.text "#{detail[:label]} #{detail[:value]}"
        # end
        pdf_filename = "#{@user.unique_identity}_details.pdf"
        send_data pdf.render, filename: pdf_filename, type: "application/pdf", disposition: "attachment"
      end
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    now = Time.zone.now.to_date
    @user.age = find_age(now)
    @user.unique_identity = unique_identity_create

    if @user.save
      redirect_to @user, allow_other_host: true
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user, allow_other_host: true
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path, allow_other_host: true
  end

  private

  def find_age(now)
    date_of_birth = user_params[:date_of_birth].to_date
    now.year - date_of_birth.year - ((now.month > date_of_birth.month || (now.month == date_of_birth.month && now.day >= date_of_birth.day)) ? 0 : 1)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender, :qrcode, :date_of_birth, :address, :avatar, :email)
  end

  def unique_identity_create
    rand.to_s[2..9]
  end
end
