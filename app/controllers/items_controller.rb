class ItemsController < ApplicationController
  before_action :set_item, only: [:edit,:update,:show,:destroy]
  before_action :set_status, only: [:show]
  before_action :set_fee, only: [:show]
  before_action :set_prefecture, only: [:show]
  before_action :set_delivery, only: [:show]
  before_action :authenticate_user! ,only: [:new]


  def index
    @items = Item.where(buyer_id: nil).order("created_at DESC").limit(3)
  end

  def new
    @item = Item.new
    @item.images.new
    
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
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      redirect_to new_item_path
    end
  end

  def edit
    @category_parent_array = Category.roots
    @category_child_array = @item.category.parent.parent.children
    @category_grandchild_array = @item.category.parent.children
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    def get_category_children
      @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
    end
  
    def get_category_grandchildren
      @category_grandchildren = Category.find("#{params[:child_id]}").children
    end
    @images = @item.images
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def show
    @images = Image.where(item_id: @item.id).order("id ASC")
    if user_signed_in?
      render :show
    else
      redirect_to new_user_session
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end

    @images = @item.images
  end
 

  private

  def item_params
    params.require(:item).permit(:name, :status, :body, :price, :fee, :region, :delivery_day, :seller_id, :category_id, images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def  set_item
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