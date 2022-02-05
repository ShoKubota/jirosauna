# frozen_string_literal: true

require './lib/places_api/places_api'
require './lib/places_api/places_photo_api'
require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require 'csv'

namespace :get_shop_data_from_places_api do
  desc 'スクレイピング処理から店舗情報取得'
  task get_jiro_data: :environment do
    puts '店舗名から二郎系のデータを取得'
    base_url = 'https://ramendb.supleks.jp'
    states = %w[tokyo kanagawa saitama chiba]
    jiros = []
    states.each do |state|
      url = "#{base_url}/search?page=1&state=#{state}&city=&order=point&station-id=0&tags=3"
      loop do
        sleep 2
        html = URI.open(url).read
        doc = Nokogiri::HTML.parse(html)
        nodes = doc.at_css('#searched').css('.name').css('h4')
        nodes.each do |node|
          unless node.previous_sibling.present?
            jiro_name = node.text
            jiros << Jiro.new(name: jiro_name)
          end
        end
        next_link = doc.at_css('.pages').at_css('.next')
        next_href = next_link.attribute('href')
        break unless next_href

        url = "#{base_url}#{next_href}"
      end
    end
    jiros.each do |jiro|
      get_places_data_from_name(jiro)
    end
  end

  task get_sauna_data: :environment do
    puts '電話番号からサウナのデータを取得する'
    base_url = 'https://www.mapion.co.jp'
    option_url = '/phonebook/M09017/'
    cities = %w[tokyo kanagawa saitama chiba]
    saunas = []
    cities.each do |city|
      CSV.foreach("lib/#{city}.csv", headers: true) do |city_code|
        url = "#{base_url}#{option_url}#{city_code['市区町村CD']}"
        loop do
          sleep 5
          html = URI.open(url, allow_redirections: :all).read
          doc = Nokogiri::HTML.parse(html)
          tel_numbers = doc.at_css('table').css('tbody').css('th + td')
          tel_numbers.each do |tel_number|
            sauna_name = tel_number.previous_sibling.previous_sibling.text.strip!
            if tel_number.text.blank?
              saunas << Sauna.new(name: sauna_name)
            else
              sauna_tel_number = tel_number.text.strip!
              saunas << Sauna.new(name: sauna_name, tel_number: sauna_tel_number)
            end
          end
          # 次のページがあれば、すすむ
          next_link = doc.at_css('.pagination-currnet + a')
          next_link.present? ? next_href = next_link.attribute('href') : break
          url = "#{base_url}#{next_href}"
        end
      end
    end
    saunas.each do |sauna|
      get_places_data_from_tel_number(sauna)
    end
  end
end

namespace :get_photos_from_places_photo_api do
  desc "店舗画像の取得"
  task get_shop_photo: :environment do
    shops = Shop.all
    shops.each do |shop|
      get_photos_from_photo_reference(shop)
    end
  end

  task test: :environment do
    shop = Shop.second
    get_photos_from_photo_reference(shop)
  end
end
