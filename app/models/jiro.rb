class Jiro < Shop
  has_many :posts, dependent: :destroy
end