require 'rails_helper'

RSpec.describe "Jiros", type: :system do
  describe '二郎一覧機能' do
    before do
      jiros = build_list(:jiro, 30)
      Jiro.import jiros
    end
    context 'jiro#indexへアクセスする' do
      it '二郎が20件表示されていること' do
        visit jiros_path
        expect(all('.jiro-card').count).to eq(20), '1ぺージに20件表示されていません'
      end
      it 'ページネーション（1ページ20件）が機能していること' do
        visit jiros_path
        click_link '2'
        sleep 1 # ページ遷移を待つ
        expect(all('.jiro-card').count).to eq(10), 'ぺージネーションが機能していません'
      end
    end
  end
end
