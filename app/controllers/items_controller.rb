class ItemsController < ApplicationController
  before_action :set_items, only: [:edit,:update,:show,:destroy]
  before_action :set_status, only: [:show]
  before_action :set_fee, only: [:show]
  before_action :set_prefecture, only: [:show]
  before_action :set_delivery, only: [:show]
  def index
  end

  def new
    @item = Item.new
    10.times {@item.images.build}
  end

  def create
    @item = Item.new(item_params)
    @image = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @images = Image.where(item_id: @item.id).order("id ASC")
  end

  def update
    @item.update(item_params)
    redirect_to item_path(@item.id)
  end

  def show
    @images = Image.where(item_id: @item.id).order("id ASC")
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :status, :body, :price, :fee, :region, :delivery_day, :seller_id, :buyer_id, images_attributes: [:image]).merge(seller_id: current_user.id)
  end

  def  set_items
    @item = Item.find(params[:id])
  end

  def  set_status
    @status = ItemStatus.find(@item.status)
  end

  def  set_fee
    @fee = ShippingFee.find(@item.fee)
  end

  def  set_prefecture
    @region = Prefecture.find(@item.region)
  end

  def  set_delivery
    @delivery = Delivery.find(@item.delivery_day)
  end
end