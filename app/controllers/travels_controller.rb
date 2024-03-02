class TravelsController < ApplicationController
  def show
  end

  def create
    @travel = Travel.new(travel_params)
    @travel.user_id = current_user.id
    if @travel.save
      redirect_to travel_path(@travel), notice: "You have created book successfully."
    else
      @travels = Travel.all
      @user = current_user
      render :index
    end
  end

  def index
    @travels = Travel.all
    @user = current_user
  end

  def edit
  end

  def travel_params
    params.require(:travel).permit(:title, :body)
  end
end
