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
        expect(page).to have_content(jiro.address), '住所が表示されていません'
        expect(page).to have_content(jiro.tel_number), '電話番号が表示されていません'
      end
      it '近くの銭湯が表示されている' do
        visit jiro_path(jiro)
        expect(all('.shop-card').count).to eq(2)
        expect(page).to have_content(near_sauna1.name), '近いサウナが表示されていません'
        expect(page).to have_content(near_sauna2.name), '近いサウナが表示されていません'
        expect(page).not_to have_content(far_sauna.name), '近くないサウナが表示されています'
      end
    end
  end
end
