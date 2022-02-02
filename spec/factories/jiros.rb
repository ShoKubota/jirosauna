# frozen_string_literal: true

FactoryBot.define do
  factory :jiro do
    type { 'Jiro' }
    sequence(:name) { |n| "ラーメン二郎#{n}店" }
    sequence(:latitude) { |n| "35.6480#{n}"}
    sequence(:longitude) { |n| "139.7416#{n}"}
    rating { 3.6 }
    opening_hours do
      '["月曜日: 12時00分～20時00分", "火曜日: 12時00分～20時00分", "水曜日: 12時00分～20時00分", "木曜日: 12時00分～20時00分", "金曜日: 12時00分～20時00分", "土曜日: 11時30分～15時00分, 17時00分～20時00分", "日曜日: 11時30分～15時00分, 17時00分～20時00分"]'
    end
    tel_number { '09-1234-5678' }
    sequence(:place_id) { |n| "jiro_place_id#{n}" }
    sequence(:address) { |n| "東京都港区1-2-#{n}" }
    
    trait :tokyo do
      sequence(:name) { |n| "ラーメン二郎東京#{n}店" }
      sequence(:latitude) { |n| "35.6480#{n}"}
      sequence(:longitude) { |n| "139.7416#{n}"}
      sequence(:address) { |n| "東京都港区1-2-#{n}" }
    end

    trait :kanagawa do
      sequence(:name) { |n| "ラーメン豚山神奈川#{n}店" }
      sequence(:latitude) { |n| "35.44917#{n}"}
      sequence(:longitude) { |n| "139.61248#{n}"}
      sequence(:address) { |n| "神奈川県横浜市青葉区1-2-#{n}" }
    end
  end
end
