# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :sauna
  belongs_to :jiro

  validates :content, presence: true, length: { maximum: 22_525 }
end
