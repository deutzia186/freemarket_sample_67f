class PurchaseController < ApplicationController
  before_action :authenticate_user!, only: [:show, :pay]
  before_action :set_item, only: [:show, :pay, :done]
  before_action :set_shippingfee, only: [:show, :done]
  before_action :set_prefecture, only: [:show, :done]

  require 'payjp'

  def show
    card = CreditCard.where(user_id: current_user.id).first
    @images = @item.images
    if card.blank?
      redirect_to controller: "credit_card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    card = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount: @item.price,
    customer: card.customer_id,
    currency: 'jpy'
  )
    if card.save
    @item.buyer_id = current_user.id
    @item.save
    redirect_to action: 'done' 
    end
  end

  def done
    @images = @item.images
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_shippingfee
    @fee = ShippingFee.find(@item.fee)
  end

  def set_prefecture
    @city = Prefecture.find(current_user.address.city)
  end

end
