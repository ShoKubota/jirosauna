require './lib/places_api/places_api.rb'
require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require 'csv'

namespace :get_shop_data_from_places_api do
  desc "スクレイピング処理"
  task get_jiro_data: :environment do
    puts "店舗名から二郎系のデータを取得"
    base_url = 'https://ramendb.supleks.jp'
    states = ['tokyo', 'kanagawa', 'saitama', 'chiba']
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
      get_places_data(jiro)
    end
  end

  task get_sauna_data: :environment do
    puts "電話番号からサウナのデータを取得する"
    base_url = 'https://www.mapion.co.jp/phonebook/M09017/'
    cities = ['tokyo', 'kanagawa', 'saitama', 'chiba']
    cities.each do |city|
      CSV.foreach("lib/#{city}.csv", headers: true) do |city_code|
        url = "#{base_url}#{city_code['市区町村CD']}"
        sleep 2
        html = URI.open(url, :allow_redirections => :all).read
        doc = Nokogiri::HTML.parse(html)
        nodes = doc.at_css('table').css('tbody').css('th + td')
        nodes.each do |node|
          sauna_tel_number = node.text.strip!
          saunas_tel_number << Sauna.new(tel_number: sauna_tel_number)
        end
      end
    end
  end
end