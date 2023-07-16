class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    now = Time.zone.now.to_date
    @user.age = find_age(now)
    @user.unique_identity = unique_identity_create

    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path
  end

  private

  def find_age(now)
    user_params[:date_of_birth] = user_params[:date_of_birth].to_date
    now.year - user_params[:date_of_birth].year - ((now.month > user_params[:date_of_birth].month || (now.month == user_params[:date_of_birth].month && now.day >= user_params[:date_of_birth].day)) ? 0 : 1)
  end

  def user_params
    params.require(:user).permit!
  end

  def unique_identity_create
    rand.to_s[2..9]
  end
end
