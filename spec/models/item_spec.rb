require 'rails_helper'
describe Item do
  describe '#create' do
    it "is invalid without a seller_id" do
      item = Item.new(name: "あ", status: "1", body: "アイウエオ", price: "500", fee: "1", region: "1", delivery_day: "2", seller_id: "", buyer_id: "1")
      item.valid?
      expect(item.errors[:seller_id]).to include("can't be blank")
    end
  end
end



