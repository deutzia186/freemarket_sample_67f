class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :category
  belongs_to :seller, class_name: "User"

  def self.search(search)
    return Item.all unless search
    Item.where(['name LIKE ?', "%#{search}%"])
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :item_status
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :delivery

    validates :name,
      presence: true,
      length: { maximum: 40 }

    validates :status,
      presence: true
    
    validates :images,
      presence: true

    validates :body,
      presence: true,
      length: { maximum: 1000 }

    validates :price,
      presence: true,
      format:{ with: /\A[a-z0-9]+\z/i },
      length: { minmum: 300 },
      length: { maximum: 9999999 }
    
    validates :fee,

      presence: true

    validates :region,
      presence: true

    validates :delivery_day,
      presence: true

    validates :seller_id,
      presence: true
  
end