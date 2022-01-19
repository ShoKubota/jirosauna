def get_places_data(shop)
  puts "APIの二郎データを取得"
  # AutoCompleteを使用してplace_idを取得する
  api_key = ENV['API_KEY']
  query = URI.encode_www_form(
    input: shop.name,
    language: 'ja',
    key: api_key
  )
  auto_complete_url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?#{query}"
  auto_page = URI.open(auto_complete_url).read
  auto_data = JSON.parse(auto_page)
  shop.place_id =  auto_data['predictions'].first['place_id']

  puts '詳細情報の取得'
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
  shop[:rating] = place_detail_data['result']['rating'] if place_detail_data['result']['rating']
  shop[:tel_number] = place_detail_data['result']['formatted_phone_number'] if place_detail_data['result']['formatted_phone_number']
  shop[:opening_hours] = place_detail_data['result']['opening_hours']['weekday_text'] if place_detail_data['result']['opening_hours']['weekday_text']
  #shop[:photo_reference] =  place_detail_data['result']['photos'][0]['photo_reference']
  shop[:address] = place_detail_data['result']['formatted_address'][/[^ \d]..??[都道府県].*/]
end