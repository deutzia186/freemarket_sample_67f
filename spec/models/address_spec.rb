require 'rails_helper'
describe User do
  describe '#create_address' do
    it "zipcode,city,town,house_numberがそれぞれ空の場合無効です。" do
      address = Address.new(zipcode:"", city:"東京都", town:"千代田区", house_number:"1")
      address.valid?
      expect(address.errors[:zipcode]).to include("can't be blank")
    end
  end
end