class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :zipcode, :city, :town, :house_number ,presence: true
end
