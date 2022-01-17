namespace :get_shop_data_from_places_api do
  desc "二郎系ラーメンのデータを取得するタスク"
  task get_jiro_data: :environment do
    puts "二郎系のデータを取得"
  end

  desc "サウナのデータを取得するタスク"
  task get_sauna_data: :environment do
    puts "サウナのデータを取得"
  end
end
