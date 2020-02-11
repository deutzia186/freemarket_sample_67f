class SearchesController < ApplicationController

  def index
    @items = Item.search(params[:search]).limit(40)
    @search = params[:search]
  end
end
