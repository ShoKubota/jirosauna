# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'MyString' }
    email { 'MyString' }
    crypted_password { 'MyString' }
    salt { 'MyString' }
    role { 1 }
    avatar { 'MyString' }
  end
end
