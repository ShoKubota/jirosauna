# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  authenticates_with_sorcery!
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 225 }
  validates :email, presence: true, uniqueness: true

  enum role: {
    general: 0,
    admin: 1
  }
end
