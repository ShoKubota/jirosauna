class Shop < ApplicationRecord
  has_many :shop_images, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :place_id, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
end
