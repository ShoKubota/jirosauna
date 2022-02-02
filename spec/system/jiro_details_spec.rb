require 'rails_helper'

RSpec.describe "Jiro_details", type: :system do
  let!(:jiro) { create(:jiro) }
  let!(:near_sauna1) { create(:sauna, latitude: 35.6505895, longitude: 139.7343765) }
  let!(:near_sauna2) { create(:sauna, latitude: 35.6549135, longitude: 139.7400412) }
  let!(:far_sauna) { create(:sauna, latitude: 35.6243273, longitude: 139.5967177) }
  describe '二郎詳細機能' do
    context 'jiro#showへアクセスする' do
      it '店舗情報が表示されている' do
        visit jiro_path(jiro)
        expect(page).to have_content(jiro.name), '店舗名が表示されていません'
        expect(page).to have_content(jiro.rating), '評価が表示されていません'
        within ('.jiro-discription') do
          expect(page.all("img[src$='/assets/star-on-1db01a995e9afbfe51f241d474fcecc932966be0b4d9b3756ef045d441da45fd.png']").count).to eq 3
          expect(page.all("img[src$='/assets/star-half-0280d033e7963483e56e2068002e6f6b44ad2b7ad84dd545ed46ce132c195cfc.png']").count).to eq 1
          expect(page.all("img[src$='/assets/star-off-0779ce5979df9c3156e71339126a81fe743a647fa28bc440f11306e494107ced.png']").count).to eq 1
        end
        expect(page).to have_content(jiro.address), '住所が表示されていません'
        expect(page).to have_content(jiro.tel_number), '電話番号が表示されていません'
      end
      it '近くの銭湯が表示されている' do
        visit jiro_path(jiro)
        expect(all('.sauna-card').count).to eq(2)
        expect(page).to have_content(near_sauna1.name), '近いサウナが表示されていません'
        expect(page).to have_content(near_sauna2.name), '近いサウナが表示されていません'
        expect(page).not_to have_content(far_sauna.name), '近くないサウナが表示されています'
      end
    end
  end
end
