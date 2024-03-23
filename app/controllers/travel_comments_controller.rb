class TravelCommentsController < ApplicationController

  def create
    travel = Travel.find(params[:travel_id])
    @comment = current_user.travel_comments.new(travel_comment_params)
    @comment.travel_id = travel.id
    @comment.save
  end

  def destroy

    @comment = TravelComment.find(params[:id]).destroy
  end

  private

  def travel_comment_params
    params.require(:travel_comment).permit(:comment)
  end

end
