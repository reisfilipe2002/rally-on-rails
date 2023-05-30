class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :orders
  has_many :cars
  has_many :cars, through: :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true, uniqueness: true, length: { minimum: 2 }
  validates :last_name, presence: true, uniqueness: true, length: { minimum: 2 }
end