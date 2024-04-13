class Admin::SearchController < ApplicationController
  def search
    @travels = Travel.search(params[:keyword]).page(params[:page]).per(5)
   @users = User.admin_search(params[:keyword]).page(params[:page]).per(5)
  end
end