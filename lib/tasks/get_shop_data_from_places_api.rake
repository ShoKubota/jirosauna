require './lib/places_api/places_api.rb'
require 'open-uri'
require 'nokogiri'

namespace :get_shop_data_from_places_api do
  desc "スクレイピング処理"
  task get_jiro_data: :environment do
    puts "二郎系のデータを取得"
    base_url = 'https://ramendb.supleks.jp'
    states = ['tokyo', 'kanagawa', 'saitama', 'chiba']
    jiros = []
    states.each do |state| 
      url = "#{base_url}/search?page=1&state=#{state}&city=&order=point&station-id=0&tags=3"
      loop do
        sleep 1
        html = URI.open(url).read
        doc = Nokogiri::HTML.parse(html)
        nodes = doc.at_css('#searched').css('.name').css('h4')
        nodes.each do |node|
          jiro_name = node.text unless node.previous_sibling
          jiros << Jiro.new(name: jiro_name)
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
    puts "サウナのデータを取得"
  end
end
