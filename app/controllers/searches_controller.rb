class SearchesController < ApplicationController
   before_action :authenticate_user!

  def search
　　@posts = Post.search(params[:search])
  end
end
