class TravelsController < ApplicationController
  def show
    @travel = Travel.find(params[:id])
  end

  def create
    @travel = Travel.new(travel_params)
    @travel.user_id = current_user.id
    if @travel.save
      redirect_to travel_path(@travel), notice: "You have created book successfully."
    else
      @travels = Travel.all.page(params[:page]).per(3)
      @user = current_user
      render :index
    end
  end

  def index
    @travels = Travel.all.page(params[:page]).per(3)
    @user = current_user
    @travel = Travel.new
  end

  def edit
  end

  def destroy
    travel = Travel.find(params[:id])
    travel.destroy
    redirect_to travels_path
  end

  def travel_params
    params.require(:travel).permit(:title, :body, :image)
  end
end
