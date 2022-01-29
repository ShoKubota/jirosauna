# frozen_string_literal: true

FactoryBot.define do
  factory :shop do
    type { '' }
    name { 'MyString' }
    longitude { 1 }
    latitude { 1 }
    rating { 1 }
    opening_hours { 'MyString' }
    tel_number { 1 }
    place_id { 'MyString' }
  end
end
