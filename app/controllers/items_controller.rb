class ItemsController < ApplicationController
  before_action :set_items, only: [:edit,:update,:show,:destroy]
  before_action :set_status, only: [:show]
  before_action :set_fee, only: [:show]
  before_action :set_prefecture, only: [:show]
  before_action :set_delivery, only: [:show]
  before_action :authenticate_user! ,only: [:new]


  def index
    @items = Item.where(buyer_id: nil).order("created_at DESC").limit(3)
  end

  def new
    @items = Item.new
    @items.images.new
    
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end
  
  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  
  def create
    @items = Item.new(item_params)
    if @items.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    
    @items = Item.find_by(id: params[:id])
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    @images = @items.images
  end

  def update
    if @items.update(item_params)
      redirect_to item_path(@items.id)
    else
      render :edit
    end
  end

  def show
    @images = Image.where(item_id: @items.id).order("id ASC")
  end

  def destroy
    if @items.destroy
      redirect_to root_path
    else
      render :show
    end
  end
 

  private

  def item_params
    params.require(:item).permit(:name, :status, :body, :price, :fee, :region, :delivery_day, :seller_id, :category_id, images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def  set_items
    @items = Item.find(params[:id])
  end

  def  set_status
    @status = ItemStatus.find(@items.status)
  end

  def  set_fee
    @fee = ShippingFee.find(@items.fee)
  end

  def  set_prefecture
    @region = Prefecture.find(@items.region)
  end

  def  set_delivery
    @delivery = Delivery.find(@items.delivery_day)
  end
end