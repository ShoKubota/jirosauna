# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Maps', type: :system do
  describe 'マップ検索機能' do
    let!(:near_jiro1) { create(:jiro, latitude: 35.6476602, longitude: 139.741758) }
    let!(:near_sauna1) { create(:sauna, latitude: 35.6505895, longitude: 139.7343765) }
    let!(:near_jiro2) { create(:jiro, latitude: 35.6514264, longitude: 139.7460494) }
    let!(:near_sauna2) { create(:sauna, latitude: 35.6549135, longitude: 139.7400412) }
    let!(:far_jiro) { create(:jiro, latitude: 35.6315829, longitude: 139.599121) }
    let!(:far_sauna) { create(:sauna, latitude: 35.6243273, longitude: 139.5967177) }

    context '中心から半径1.5km以内に二郎とサウナがある場合' do
      before do
        # 曜日に対応した営業時間の表示をテストするため日にちを固定する(2022/1/29(土)) 
        travel_to Date.new(2022, 1, 29) do
          visit maps_path
          # 中心の設定
          page.execute_script("document.getElementById('lat').value = '35.64806'")
          page.execute_script("document.getElementById('lng').value = '139.7416326'")
          click_button('周辺の二郎とサウナを探す')
          expect(current_path).to eq(maps_path), 'mapsページへリダイレクトされていません'
        end
      end
      it '近い順に店舗の詳細情報が表示されている' do
        # 画像の区別はできないため個数で判定する 1(ピン) + 2(二郎) 2（サウナ）
        within('#map') do
          expect(page.all("img[src$='https://maps.gstatic.com/mapfiles/transparent.png']").count).to eq 5
        end
        expect(page.all('.shop-card')[0]).to have_content(near_jiro1.name), '近い順に並んでいません'
        expect(page.all('.shop-card')[1]).to have_content(near_jiro2.name), '近い順に並んでいません'
        expect(page.all('.shop-card')[2]).to have_content(near_sauna1.name), '近い順に並んでいません'
        expect(page.all('.shop-card')[3]).to have_content(near_sauna2.name), '近い順に並んでいません'
        expect(page).not_to have_content(far_jiro.name), '範囲内の二郎店舗が取得できていません'
        expect(page).not_to have_content(far_sauna.name), '範囲内のサウナ店舗が取得できていません'
      end
      it '詳細情報に評価・営業時間・中心からの距離が正しく表示されていること' do
        within first('.shop-card') do
          expect(page).to have_content(near_jiro1.rating), '評価が表示されていません'
          expect(page).to have_content('土曜日: 11時30分～15時00分, 17時00分～20時00分'), '営業時間が正しく表示されていません'
          expect(page).to have_content('中心から約 30 m'), '距離が一致しません'
        end
      end
      it '検索結果の店舗をクリックすると、詳細ページへ遷移できる' do
        click_link near_jiro1.name
        expect(current_path).to eq(jiro_path(near_jiro1))
      end
    end
    context '中心から半径1.5km以内に該当店舗（サウナ・二郎）がない場合' do
      it 'ピンは差されず「見つかりませんでした」と表示される' do
        visit maps_path
        # 中心の設定
        page.execute_script("document.getElementById('lat').value = '35.6355045'")
        page.execute_script("document.getElementById('lng').value = '139.7131368'")
        click_button '周辺の二郎とサウナを探す'
        expect(current_path).to eq(maps_path), 'mapsページへリダイレクトされていません'
        expect(page).to have_content('近くの二郎系は見つかりませんでした'), '見つからない場合のメッセージが表示されていません'
        expect(page).to have_content('近くの銭湯・サウナは見つかりませんでした'), '見つからない場合のメッセージが表示されていません'
      end
    end
  end
end
