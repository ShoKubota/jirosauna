def get_places_data(shop)
  # API節約のため、にデータを取得済みの場合は、exitする
  return if aleady_exist?(shop)
  puts "#{shop.name}のPlace_idを取得"
  # AutoCompleteを使用してplace_idを取得する
  api_key = ENV['API_KEY']
  query = URI.encode_www_form(
    input: shop.name,
    language: 'ja',
    key: api_key
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
      key: api_key
    )
    text_research_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?#{query}"
    text_research_page = URI.open(text_research_url).read
    text_research_data = JSON.parse(text_research_page)
    # text検索でも見つからない場合は、閉店とみなし、情報の取得はしない
    text_research_data['results'].present? ? shop.place_id = text_research_data['results'].first['place_id'] : return
  end

  puts "#{shop.name}の詳細情報の取得"
  place_detail_query = URI.encode_www_form(
    place_id: shop.place_id,
    language: 'ja',
    key: api_key
  )
  place_detail_url = "https://maps.googleapis.com/maps/api/place/details/json?#{place_detail_query}"
  place_detail_page = URI.open(place_detail_url).read
  place_detail_data = JSON.parse(place_detail_page)

  shop[:longitude] = place_detail_data['result']['geometry']['location']['lng']
  shop[:latitude] = place_detail_data['result']['geometry']['location']['lat']
  shop[:rating] = place_detail_data['result']['rating'] if place_detail_data['result']['rating'].present?
  shop[:tel_number] = place_detail_data['result']['formatted_phone_number'] if place_detail_data['result']['formatted_phone_number'].present?
  shop[:opening_hours] = place_detail_data['result']['opening_hours']['weekday_text'] if place_detail_data['result']['opening_hours'].present?
  shop[:photo_reference] =  place_detail_data['result']['photos'][0]['photo_reference'] if place_detail_data['result']['photos'].present?
  shop[:address] = place_detail_data['result']['formatted_address'][/[^ \d]..?[都道府県].*/]
  shop.save
end

def aleady_exist?(shop)
  Jiro.find_by(name: shop.name) ? true : false
end