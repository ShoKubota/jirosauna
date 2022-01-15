class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 225 }
  validates :email, presence: true, uniquness: true

  enum role: {
    general: 0,
    admin: 1
  }
end
