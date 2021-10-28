class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 30 }

  #with_options on: :update do
  #validates :introduction, presence: true, length: { maximum: 100 }
  #end

  has_one_attached :avatar
  has_many :hotels
end
