# frozen_string_literal: true

FactoryBot.define do
  factory :shop_image do
    image { 'MyString' }
    shop { nil }
  end
end
