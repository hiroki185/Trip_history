class FavoritesController < ApplicationController

 def create
  
   @travel = Travel.find(params[:travel_id])
   favorite = current_user.favorites.new(travel_id: @travel.id)
   favorite.save
 end

 def destroy
   @travel = Travel.find(params[:travel_id])
   favorite = current_user.favorites.find_by(travel_id: @travel.id)
   favorite.destroy
 end
end
