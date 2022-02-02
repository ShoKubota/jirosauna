require 'rails_helper'

RSpec.describe "SearchJiros", type: :system do
  let!(:jiro_tokyo) { create(:jiro, :tokyo, name: 'ラーメン二郎') }
  let!(:jiro_kanagawa) { create(:jiro, :kanagawa, name: 'ラーメン豚山') }

  describe '二郎検索機能' do
    context '名前であいまい検索する' do
      it 'キーワードに一致する名前の店舗が表示される' do
        visit jiros_path
        fill_in('q[name_or_address_cont]', with: '二郎')
        click_button '検索する'
        expect(page).to have_content(jiro_tokyo.name), '名前での検索が失敗しています'
        expect(page).not_to have_content(jiro_kanagawa.name), '名前での検索が失敗しています'
      end
    end
    context 'エリアであいまい検索する' do
      it 'エリアに該当する店舗が表示される' do
        visit jiros_path
        fill_in('q[name_or_address_cont]', with: '神奈川')
        click_button '検索する'
        expect(page).to have_content(jiro_kanagawa.name), 'エリアでの検索が失敗しています'
        expect(page).not_to have_content(jiro_tokyo.name), 'エリアでの検索が失敗しています'
      end
    end
  end
end
