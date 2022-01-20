def get_places_data_from_name(shop)
  # API節約のため、にデータを取得済みの場合は、returnする
  return if aleady_exist?(shop)
  # AutoCompleteを使用してplace_idを取得する
  get_place_id_from_name(shop)
  # Detailサーチで詳細情報を取得→保存する
  if shop.place_id
    get_detail_data(shop)
    shop.save
    p "#{shop.name}の情報を保存しました"
  else
    p "見つかりませんでした"
  end
end

def get_places_data_from_tel_number(shop)
  # API節約のため、にデータを取得済みの場合は、returnする
  return if aleady_exist?(shop)
  # FindPlaceFromText（PhoneNumber）を使用してplace_idを取得する、ない場合は名前で取得
  get_place_id_from_tel_number(shop) if shop.tel_number.present?
  get_place_id_from_name(shop) if shop.place_id.nil?
  # place_idを取得できた場合、Detailサーチで詳細情報を取得→保存する
  if shop.place_id
    get_detail_data(shop)
    shop.save
    p "#{shop.name}の情報を保存しました"
  else
    p "見つかりませんでした"
  end
end

def get_place_id_from_name(shop)
  puts "名前から#{shop.name}のPlace_idを取得"
  # AutoCompleteを使用してplace_idを取得する
  query = URI.encode_www_form(
    input: shop.name,
    language: 'ja',
    key: ENV['API_KEY']
  )
  auto_complete_url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?#{query}"
  auto_complete_page = URI.open(auto_complete_url).read
  auto_complete_data = JSON.parse(auto_complete_page)
  if auto_complete_data['predictions'].present?
    shop.place_id =  auto_complete_data['predictions'].first['place_id']
  else
    # auto_completeで見つからない場合、text検索で取得する
    query = URI.encode_www_form(
      query: shop.name,
      language: 'ja',
      key: ENV['API_KEY']
    )
    text_research_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?#{query}"
    text_research_page = URI.open(text_research_url).read
    text_research_data = JSON.parse(text_research_page)
    # text検索でも見つからない場合は、閉店とみなし、情報の取得はしない
    shop.place_id = text_research_data['results'].first['place_id'] if text_research_data['results'].present?
  end

  shop
end

def get_place_id_from_tel_number(shop)
  puts "電話番号から#{shop.name}のPlace_idを取得"
  tel_number = PhonyRails.normalize_number(shop.tel_number, country_code: 'JP')
  query = URI.encode_www_form(
    input: tel_number,
    inputtype: 'phonenumber',
    language: 'ja',
    key: ENV['API_KEY']
  )
  phone_research_url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?#{query}"
  phone_research_page = URI.open(phone_research_url).read
  phone_research_data = JSON.parse(phone_research_page)
  shop.place_id =  phone_research_data['candidates'].first['place_id'] if phone_research_data['candidates'].present?
end

def get_detail_data(shop)
  puts "詳細情報の取得"
  place_detail_query = URI.encode_www_form(
    place_id: shop.place_id,
    language: 'ja',
    key: ENV['API_KEY']
  )
  place_detail_url = "https://maps.googleapis.com/maps/api/place/details/json?#{place_detail_query}"
  place_detail_page = URI.open(place_detail_url).read
  place_detail_data = JSON.parse(place_detail_page)

  shop[:longitude] = place_detail_data['result']['geometry']['location']['lng']
  shop[:latitude] = place_detail_data['result']['geometry']['location']['lat']
  shop[:rating] = place_detail_data['result']['rating'] if place_detail_data['result']['rating'].present?
  shop[:tel_number] = place_detail_data['result']['formatted_phone_number'] if place_detail_data['result']['formatted_phone_number'].present?
  shop[:opening_hours] = place_detail_data['result']['opening_hours']['weekday_text'] if place_detail_data['result']['opening_hours'].present?
  shop[:photo_reference] = place_detail_data['result']['photos'][0]['photo_reference'] if place_detail_data['result']['photos'].present?
  shop[:address] = place_detail_data['result']['formatted_address'][/[^ \d]..?[都道府県].*/]

  shop
end

def aleady_exist?(shop)
  Jiro.find_by(name: shop.name) ? true : false
end