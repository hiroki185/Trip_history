class UsersController < ApplicationController
before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @travels = @user.travels.page(params[:page]).per(6)
    @travel = Travel.new
  end

  def search
    @user = current_user
    @users = User.search(params[:keyword]).page(params[:page]).per(20)
  end

  def index
    @users = User.all.page(params[:page]).per(10)
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    @travel = @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      @travels = Travel.all
      @travel = Travel.new
      render :edit
    end
  end

  def favorites
    if params[:latest]
      @favorite_travels = current_user.favorite_travels.latest.page(params[:page]).per(6)
    elsif params[:old]
      @favorite_travels = current_user.favorite_travels.old.page(params[:page]).per(6)
    elsif params[:favorite]
      @favorite_travels = current_user.favorite_travels.includes(:favorites).order('favorites.created_at DESC').sort_by { |travel| travel.favorites.count }.reverse
      @favorite_travels = Kaminari.paginate_array(@favorite_travels).page(params[:page]).per(6)
    else
      @favorite_travels = current_user.favorite_travels.page(params[:page]).per(6)
    end
  end

  def unsubscribe

  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true) #is_deletedカラムをtrueに変更することにより削除フラグを立てる
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :body)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def is_matching_login_user
    if current_user.nil? || params[:id].to_i != current_user.id
      redirect_to root_path
    end
  end


end
