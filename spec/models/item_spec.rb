require 'rails_helper'
describe Item do
  describe '#create' do
    it "is invalid without a nickname" do
      item = Item.new(name: "", status: "1", body: "アイウエオ", price: "500", fee: "1", region: "1", delivery_day: "2")
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end
  end
end



