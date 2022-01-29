# frozen_string_literal: true

class Sauna < Shop
  has_many :posts, dependent: :destroy
end
