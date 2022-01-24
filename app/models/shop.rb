class Shop < ApplicationRecord
  acts_as_mappable :default_units => :kms,
                    :default_formula => :sphere,
                    :distance_field_name => :distance,
                    :lat_column_name => :latitude,
                    :lng_column_name => :longitude

  has_many :shop_images, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :place_id, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
end
