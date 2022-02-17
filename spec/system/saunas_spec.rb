require 'rails_helper'

RSpec.describe "Saunas", type: :system do
  describe 'サウナ一覧機能' do
    before do
      saunas = build_list(:sauna, 30)
      Sauna.import saunas
    end
    context 'sauna#indexへアクセスする' do
      it 'サウナが20件表示されていること' do
        visit saunas_path
        expect(all('.sauna-card').count).to eq(20), '1ぺージに20件表示されていません'
      end
      it 'ページネーション（1ページ20件）が機能していること' do
        visit saunas_path
        click_link '2'
        sleep 1 # ページ遷移を待つ
        expect(all('.sauna-card').count).to eq(10), 'ぺージネーションが機能していません'
      end
    end
  end
end
