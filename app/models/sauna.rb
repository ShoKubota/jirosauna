class Sauna < Shop
  has_many :posts, dependent: :destroy
end