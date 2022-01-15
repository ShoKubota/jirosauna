class Shop < ApplicationRecord
  has_many :shop_images, dependent: :destroy

  validates :name, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :place_id, presence: true
end
