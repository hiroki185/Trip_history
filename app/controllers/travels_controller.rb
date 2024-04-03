class TravelsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
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
    tags = Vision.get_image_data(travel_params[:image])
    if @travel.save
      tags.each do |tag|
        @travel.tags.create(name: tag)
      end
      redirect_to travel_path(@travel), notice: "You have created book successfully."
    else
      @travels = Travel.all.page(params[:page]).per(12)
      @user = current_user
      render :new
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
    @travels_searches = Travel.search(params[:keyword]).page(params[:page]).per(12)
  end

  def index
    @user = current_user
    @travel = Travel.new
    if params[:latest]
      @travels = Travel.latest.page(params[:page]).per(12)
    elsif params[:old]
      @travels = Travel.old.page(params[:page]).per(12)
    elsif params[:favorite]
      @travels = Travel.includes(:favorites).order('favorites.created_at DESC').sort_by { |travel| travel.favorites.count }.reverse
     @travels = Kaminari.paginate_array(@travels).page(params[:page]).per(12)
    else
      @travels = Travel.all.page(params[:page]).per(12)
    end
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



def is_matching_login_user
  @travel = Travel.find(params[:id])
  return if @travel.present?
  redirect_to root_path
end

end