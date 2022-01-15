class Post < ApplicationRecord
  belongs_to :user
  belongs_to :sauna
  belongs_to :jiro

  validates :content, presence: true, length: { maximum: 22525 }
end
