class Item < ApplicationRecord
  belongs_to :user,foreign_key: 'user_id'
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

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


    # User機能が実装できたらコメントアウトを外す
    # validates :seller_id,
      # presence: true
