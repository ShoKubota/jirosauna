# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "銭湯二郎#{n}号" }
    sequence(:email) { |n| "jiro{n}@example.com"}
    password { 'password' }
    password_confirmation { 'password' }
    role { 0 }
  end
end
