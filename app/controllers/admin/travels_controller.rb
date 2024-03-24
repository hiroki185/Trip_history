class Admin::TravelsController < ApplicationController
before_action :authenticate_admin!
  def show
    @travel = Travel.find(params[:id])
    @travel_comment = TravelComment.new
  end

  def index
    @travels = Travel.all.page(params[:page]).per(10)
  end

  def edit
    @travel = Travel.find(params[:id])
    @amount_ranges = ['0円', '0～5000円', '5000円～1万円', '1万円～3万円', '3万円～5万円', '5万円以上']
    @transportations = ['徒歩', '自転車', '自動車', '電車', 'バス', '飛行機', '船']
  end

  def update
    @travel = Travel.find(params[:id])
    if @travel.update(travel_params)
      redirect_to admin_travel_path(@travel.id), notice: "編集が完了しました。"
    else
      render :edit
    end
  end

  def destroy
    travel = Travel.find(params[:id])
    travel.destroy
    redirect_to admin_travels_path
  end

  def destroy_comment
    @comment = TravelComment.find(params[:id]).destroy
  end

  private

  def travel_params
    params.require(:travel).permit(:title, :body, :image, :amount_range, :transportation, :address, :category)
  end

end
