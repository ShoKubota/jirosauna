# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    content { 'MyText' }
    user { nil }
    sauna { nil }
    jiro { nil }
  end
end
