class TravelsController < ApplicationController

  before_action :authenticate_user!

  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @travel = Travel.find(params[:id])
    @travel_comment = TravelComment.new
    @categories = Travel.unique_categories
    @travel_detail  = Travel.joins(:view_counts).group(:id).order('COUNT(view_counts.id) DESC').page(params[:page]).per(50).limit(4)
    unless ViewCount.find_by(user_id: current_user.id, travel_id: @travel.id)
      current_user.view_counts.create(travel_id: @travel.id)
    end
  end

  def new
    @travel = Travel.new
  end

  def create
    @travel = Travel.new(travel_params)
    @travel.user_id = current_user.id
    if travel_params[:image].present?
      tags = Vision.get_image_data(travel_params[:image])
    end
    if @travel.save
      if travel_params[:image].present?
        tags.each do |tag|
          @travel.tags.create(name: tag)
        end
      end
      redirect_to travel_path(@travel), notice: "You have created book successfully."
    else
      @travels = Travel.all.page(params[:page]).per(50)
      @user = current_user
      render :new
    end
  end

  def update
    @travel = Travel.find(params[:id])
    if travel_params[:image].present?
      tags = Vision.get_image_data(travel_params[:image])
    end
    if @travel.update(travel_params)
      if travel_params[:image].present?
        @travel.tags.destroy_all
        tags.each do |tag|
          @travel.tags.create(name: tag)
        end
      end
      redirect_to @travel, notice: "編集が完了しました。"
    else
      render :edit
    end
  end

  def search
    @travels_searches = Travel.search(params[:keyword]).page(params[:page]).per(50)
    @travels = Travel.all.page(params[:page]).per(50)
     @categories = Travel.unique_categories
    @travel_detail  = Travel.joins(:view_counts).group(:id).order('COUNT(view_counts.id) DESC').page(params[:page]).per(50).limit(4)
  end


  def index

    @user = current_user
    @travel = Travel.new
     @categories = Travel.unique_categories
    if params[:latest]
      @travels = Travel.latest.page(params[:page]).per(50)
    elsif params[:old]
      @travels = Travel.old.page(params[:page]).per(50)
    elsif params[:favorite]
      @travels = Travel.includes(:favorites).order('favorites.created_at DESC').sort_by { |travel| travel.favorites.count }.reverse
      @travels = Kaminari.paginate_array(@travels).page(params[:page]).per(50)

    else
      @travels = Travel.all.page(params[:page]).per(50)
    end
    @travel_detail  = Travel.joins(:view_counts).group(:id).order('COUNT(view_counts.id) DESC').page(params[:page]).per(50).limit(4)
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

  def destroy_all
    current_user.travels.destroy_all
    redirect_to user_path(current_user)
  end

   def destroy_selected
     selected_ids = params[:selected_travels] || []
     Travel.where(id: selected_ids).destroy_all
     redirect_to user_path(current_user), notice: "選択した項目を削除しました。"
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

