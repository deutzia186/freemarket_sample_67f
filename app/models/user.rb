class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana,  presence: true

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, {presence: true, , format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}

  # validates :passward, presence: true, length: { minimum: 7 }

  has_one :address
end
