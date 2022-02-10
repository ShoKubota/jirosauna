# frozen_string_literal: true

class Shop < ApplicationRecord
  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   distance_field_name: :distance,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  has_many :shop_images, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :place_id, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true

  def opening_hour_today
    return '現在調査中です。' unless opening_hours

    array_opening_hour = opening_hours.delete('\"[]').split(',')
    opening_hour = array_opening_hour.slice_when { |_a, b| b.include?('曜日') }.to_a
    case Date.today.wday
    when 0
      opening_hour[6].join(',')
    when 1
      opening_hour[0].join(',')
    when 2
      opening_hour[1].join(',')
    when 3
      opening_hour[2].join(',')
    when 4
      opening_hour[3].join(',')
    when 5
      opening_hour[4].join(',')
    else
      opening_hour[5].join(',')
    end
  end

  def get_opening_hour
    return '現在調査中です。' unless opening_hours

    array_opening_hour = opening_hours.delete('\"[]').split(',')
    opening_hour = array_opening_hour.slice_when { |_a, b| b.include?('曜日') }.to_a
  end


  def show_tel_number
    tel_number.present? ? tel_number : '非公開'
  end

  def get_distance(latitude, longitude)
    point = Geokit::LatLng.new(latitude, longitude)
    distance = distance_to(point) * 1000
    distance.round(-1)
  end

  def appearance_image
    if shop_images[0]
      shop_images[0].image
    elsif type == 'Jiro'
      'sample_image.jpg'
    else
      'sample_image_sauna.jpg'
    end
  end

  def shop_type
    type == 'Jiro' ? '二郎系ラーメン' : '銭湯・サウナ'
  end
end
