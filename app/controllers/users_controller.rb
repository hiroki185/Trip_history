class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find(params[:id])
    @travels = @user.travels.page(params[:page]).per(6)
    @travel = Travel.new
  end

  def search
    @user = current_user
    @users = User.search(params[:keyword]).page(params[:page]).per(6)
  end
  
  def index
    @users = User.all.page(params[:page]).per(6)
    @user = current_user
  end

  def edit
   @user = User.find(params[:id])
   @travel = @user
  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      @travels = Travel.all
      @travel = Travel.new
      render :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdrawal
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile_image)
  end
  
    def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end 
end
