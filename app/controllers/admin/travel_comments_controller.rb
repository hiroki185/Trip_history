class Admin::TravelCommentsController < ApplicationController
  def destroy
    @comment = TravelComment.find(params[:id])
    @comment.destroy
    redirect_to admin_travel_path(@comment.travel), notice: "コメントが削除されました。"
  end
end