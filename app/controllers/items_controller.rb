class ItemsController < ApplicationController
  before_action :authenticate_user! ,only: [:new]

  def index
  end

  def new
    @item = Item.new
    10.times {@item.images.build}
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :status, :body, :price, :fee, :region, :delivery_day, :seller_id, :buyer_id, images_attributes: [:image]).merge(seller_id: current_user.id)
  end
end
