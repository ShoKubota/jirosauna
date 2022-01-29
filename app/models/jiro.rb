# frozen_string_literal: true

class Jiro < Shop
  has_many :posts, dependent: :destroy
end
