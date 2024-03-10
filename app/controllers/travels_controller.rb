class TravelsController < ApplicationController
  def show
    @travel = Travel.find(params[:id])
    @travel_comment = TravelComment.new
  end
  
  
  def new
    @travel = Travel.new
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
  
  def update
  @travel = Travel.find(params[:id])
  
  if @travel.update(travel_params)
    redirect_to @travel, notice: "編集が完了しました。"
  else
    render :edit
  end
end

  def search
    @travels_searches = Travel.search(params[:keyword]).page(params[:page]).per(5)
  end

  def index
    @travels = Travel.all.page(params[:page]).per(5)
    @travel = Travel.new
    @user = current_user
  end

  def edit
   @travel = Travel.find(params[:id])
   @amount_ranges = ['0円', '0～5000円', '5000円～1万円', '1万円～3万円', '3万円～5万円', '5万円以上']
   @transportations = ['徒歩', '自転車', '自動車', '電車', 'バス', '飛行機', '船']
  end

  def destroy
    travel = Travel.find(params[:id])
    travel.destroy
    redirect_to user_path(current_user)
  end
  
private

  def travel_params
    params.require(:travel).permit(:title, :body, :image, :amount_range, :transportation, :address, :category)
  end
end
