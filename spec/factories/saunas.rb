# frozen_string_literal: true

FactoryBot.define do
  factory :sauna do
    type { 'Sauna' }
    sequence(:name) { |n| "スーパー銭湯#{n}店" }
    sequence(:latitude) { |n| "35.6480#{n}"}
    sequence(:longitude) { |n| "139.7416#{n}"}
    rating { 3.2 }
    opening_hours do
      '["月曜日: 10時00分～22時00分", "火曜日: 10時00分～22時00分", "水曜日: 10時00分～22時00分", "木曜日: 10時00分～22時00分", "金曜日: 10時00分～22時00分", "土曜日: 10時00分～22時00分", "日曜日: 10時00分～22時00分"]'
    end
    tel_number { '03-9876-5432' }
    sequence(:place_id) { |n| "sauna_place_id#{n}" }
    sequence(:address) { |n| "東京都港区4-5-#{n}" }

    trait :tokyo do
      sequence(:name) { |n| "スーパー銭湯東京#{n}店" }
      sequence(:latitude) { |n| "35.6480#{n}"}
      sequence(:longitude) { |n| "139.7416#{n}"}
      sequence(:address) { |n| "東京都港区1-2-#{n}" }
    end

    trait :kanagawa do
      sequence(:name) { |n| "スーパー銭湯神奈川#{n}店" }
      sequence(:latitude) { |n| "35.44917#{n}"}
      sequence(:longitude) { |n| "139.61248#{n}"}
      sequence(:address) { |n| "神奈川県横浜市青葉区1-2-#{n}" }
    end
  end
end
