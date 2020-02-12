class UsersController < ApplicationController
  def index
    @items = Item.where(seller_id: current_user.id).order("created_at ASC")
  end
  def new
  end
  def show
  end
end