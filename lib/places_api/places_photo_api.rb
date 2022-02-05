def get_photos_from_photo_reference(shop)
  # photo_referenceがある場合のみ処理を実行する
  return if shop.photo_reference.nil? || shop.shop_images.present?
  #既に取得済みのものは取得しない
  puts "#{shop.name}の画像を取得"
  query = URI.encode_www_form(
    photo_reference: shop.photo_reference,
    maxwidth: 400,
    key: ENV['API_KEY']
  )
  place_photo_url = "https://maps.googleapis.com/maps/api/place/photo?#{query}"
  # 画像URLを開き取得した後、新規作成したファイルにバイナリ形式で書き込む
  URI.open(place_photo_url) { |image|
    File.open("app/assets/images/#{shop.type.downcase}_appearance_#{shop.id}.jpg", 'wb') do |file|
      file.puts image.read
    end
  }
  # 対応する画像URLをテーブルに保存する
  shop_image = ShopImage.new(shop: shop, image: "#{shop.type.downcase}_appearance_#{shop.id}.jpg")
  shop_image.save
end 