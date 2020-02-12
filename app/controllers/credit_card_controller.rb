class CreditCardController < ApplicationController

  require "payjp"
  
  def new
    card = CreditCard.where(user_id: current_user.id)
    redirect_to credit_card_index_path if card.exists?
  end
  def pay 
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to new_credit_card_path
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', 
      email: current_user.email, 
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to credit_card_index_path
      else
        redirect_to pay_credit_card_index
      end
    end
  end
  def delete 
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
      redirect_to new_credit_card_path
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
      redirect_to new_credit_card_path
    end
  end
  def show 
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
      redirect_to new_credit_card_path
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
end
