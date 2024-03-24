class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.all.page(params[:page]).per(20)
  end

  def edit

  end

  def update

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました。"
  end

end
