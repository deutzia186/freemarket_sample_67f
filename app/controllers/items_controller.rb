class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    10.times {@item.images.build}
    
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
      render 'new'
    end
  end

 

  private

  def item_params
    params.require(:item).permit(:name, :status, :body, :price, :fee, :region, :delivery_day, :seller_id, :buyer_id, images_attributes: [:image] )
  end

  # user機能が実装できたらitem_params内と入れ替える
  # params.require(:item).permit(:name, :status, :body, :price, :fee, :region, :delivery_day, :seller_id, :buyer_id, images_attributes: [:image] ).merge(seller_id: current_user.id )

end
