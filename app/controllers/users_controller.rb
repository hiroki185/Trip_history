class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @travels = @user.travels.page(params[:page]).per(6)
    @travel = Travel.new
  end


  def index
    @users = User.all
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

  private

    def user_params
    params.require(:user).permit(:name,:profile_image)
  end
end
