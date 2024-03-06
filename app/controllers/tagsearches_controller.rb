class TagsearchesController < ApplicationController
  def search
    @model = Travel  #search機能とは関係なし
    @word = params[:content]
    @travels = Travel.where("category LIKE?","%#{@word}%").page(params[:page]).per(5)
    render "tagsearches/tagsearch"
  end
end
