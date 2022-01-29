# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 225 }
  validates :email, presence: true, uniqueness: true

  enum role: {
    general: 0,
    admin: 1
  }
end
