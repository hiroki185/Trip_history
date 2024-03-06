class TravelsController < ApplicationController
  def show
    @travel = Travel.find(params[:id])
    @travel_comment = TravelComment.new
  end

  def create
    @travel = Travel.new(travel_params)
    @travel.user_id = current_user.id
    if @travel.save
      redirect_to travel_path(@travel), notice: "You have created book successfully."
    else
      @travels = Travel.all.page(params[:page]).per(5)
      @user = current_user
      render :index
    end
  end

  def search
    @travels_searches = Travel.search(params[:keyword])
    @travels = Travel.all.page(params[:page]).per(5)
  end

  def index
    @travels = Travel.all.page(params[:page]).per(5)
    @travel = Travel.new
    @user = current_user
  end

  def edit
  end

  def destroy
    travel = Travel.find(params[:id])
    travel.destroy
    redirect_to travels_path
  end

  def travel_params
    params.require(:travel).permit(:title, :body, :image, :amount_range, :transportation, :address, :category)
  end
end
