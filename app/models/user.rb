class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :phone_number, :year_birth_at, :month_birth_at, :day_birth_at ,presence: true
  validates :email, uniqueness: true
  validates :last_name, :first_name, presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :last_name_kana, :first_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :password,    length: { minimum: 7 } 
  has_one :address
  has_many :items

end
