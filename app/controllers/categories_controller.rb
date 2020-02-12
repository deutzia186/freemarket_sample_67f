class CategoriesController < ApplicationController
  def index
    @parents = Category.all.order("ancestry").order("id ASC").limit(13)  #ancestryカラムの上から13個目のカラムを取得
    @children = parent.children.create(name: child)
    respond_to do |format|
      format.html
      format.json { render json: @parents}
    end
  end
end
