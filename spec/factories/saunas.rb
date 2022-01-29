FactoryBot.define do
  factory :sauna do
    type { "Sauna" }
    sequence(:name) { |n| "スーパー銭湯#{n}店" }
    rating { 3.6 }
    opening_hours { "[\"月曜日: 10時00分～22時00分\", \"火曜日: 10時00分～22時00分\", \"水曜日: 10時00分～22時00分\", \"木曜日: 10時00分～22時00分\", \"金曜日: 10時00分～22時00分\", \"土曜日: 10時00分～22時00分\", \"日曜日: 10時00分～22時00分\"]" }
    tel_number { "03-9876-5432" }
    sequence(:place_id) { |n| "sauna_place_id#{n}" }
    sequence(:address){ |n| "東京都港区4-5-#{n}" }
  end
end
