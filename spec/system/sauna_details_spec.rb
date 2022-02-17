require 'rails_helper'

RSpec.describe "SaunaDetails", type: :system do
  describe 'サウナ詳細機能' do
    let!(:sauna) { create(:sauna) }
    let!(:near_jiro1) { create(:jiro, latitude: 35.6505895, longitude: 139.7343765) }
    let!(:near_jiro2) { create(:jiro, latitude: 35.6549135, longitude: 139.7400412) }
    let!(:far_jiro) { create(:jiro, latitude: 35.6243273, longitude: 139.5967177) }
    context 'sauna#showへアクセスする' do
      it '店舗情報が表示されている' do
        visit sauna_path(sauna)
        expect(page).to have_content(sauna.name), '店舗名が表示されていません'
        expect(page).to have_content(sauna.rating), '評価が表示されていません'
        expect(page).to have_content(sauna.address), '住所が表示されていません'
        expect(page).to have_content(sauna.tel_number), '電話番号が表示されていません'
      end
      it '近くの二郎が表示されている' do
        visit sauna_path(sauna)
        expect(all('.shop-card').count).to eq(2)
        expect(page).to have_content(near_jiro1.name), '近い二郎が表示されていません'
        expect(page).to have_content(near_jiro2.name), '近い二郎が表示されていません'
        expect(page).not_to have_content(far_jiro.name), '近くない二郎が表示されています'
      end
      it '近くの二郎をクリックすると、詳細ページへ遷移する' do
        visit sauna_path(sauna)
        click_link near_jiro1.name
        expect(current_path).to eq(jiro_path(near_jiro1))
      end
    end
  end
end
