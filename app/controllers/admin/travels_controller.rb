class Admin::TravelsController < ApplicationController

  def show
    @travel = Travel.find(params[:id])
    @travel_comment = TravelComment.new
  end

  def index
    @travels = Travel.all
  end

  def edit

  end


end
