require 'rails_helper'
describe User do
  describe '#create' do
    it "nickname,phone_number,year_birth_at,month_birth_at,day_birth_atがそれぞれ空の場合無効です。" do
      user = User.new(nickname: "", phone_number: "09000000000", year_birth_at: "1900", month_birth_at: "1", day_birth_at: "1",  email: "kkk@gmail.com", password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
  end
end