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
    @item = Item.new
    @item.images.new

    
    #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    #.whereは任意のデータベースから任意の条件を指定し条件に当てはまるレコードをすべて取得する
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end
   # 以下全て、formatはjsonのみ
   # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
  #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
      @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
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
  end

  def destroy
    if @item.destroy
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