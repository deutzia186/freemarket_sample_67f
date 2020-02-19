class SearchesController < ApplicationController
  before_action :set_ransack

  def index
    @items = Item.search(params[:search]).limit(40)
    @search = params[:search]
  end

  def detail
    @search = params[:q][:name_cont]
    @search_item = Item.ransack(params[:q]) 
    @result_items = @search_item.result.page(params[:page])
  end

  private

  def set_ransack
    @q = Item.ransack(params[:q])
  end

end
