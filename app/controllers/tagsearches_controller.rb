class TagsearchesController < ApplicationController
  def search
    @model = Travel  #search機能とは関係なし
    @word = params[:content]
    @travel_search = Travel.where("category LIKE?","%#{@word}%").page(params[:page]).per(50)
    @travels = Travel.all.page(params[:page]).per(50)
    @categories = Travel.unique_categories
    @travel_detail  = Travel.joins(:view_counts).group(:id).order('COUNT(view_counts.id) DESC').page(params[:page]).per(50).limit(4)
    render "tagsearches/tagsearch"
  end
end
