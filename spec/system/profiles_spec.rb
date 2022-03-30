require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  describe 'プロフィール編集機能' do
    describe 'ログイン前' do
      it 'プロフィールページへアクセスしてもリダイレクトされる' do
        visit profile_path
        expect(current_path).to eq root_path
      end
    end
    describe 'ログイン後' do
      let(:user) { create(:user) }
      let(:existed_user) { create(:user) }
      before do
        login(user)
        visit edit_profile_path
      end
      context '全ての変更値が正常' do
        it '正しく編集される' do
          fill_in 'user[name]', with: '三島由紀夫'
          fill_in 'user[email]', with: 'mishima@example.com'
          attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/image/test-profile.png"
          click_button '更新する'
          expect(current_path).to eq profile_path
          expect(page).to have_content('三島由紀夫')
          expect(page).to have_selector("img[src$='test-profile.png']")
        end
      end
      context 'メールアドレスが重複している' do
        it '編集に失敗する' do
          fill_in 'user[name]', with: '三島由紀夫'
          fill_in 'user[email]', with: existed_user.email
          attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/image/test-profile.png"
          click_button '更新する'
          expect(current_path).to eq profile_path
          expect(page).to have_content('メールアドレスはすでに存在します')
        end
      end
      context '画像がjpeg,jpg,png以外' do
        it '編集に失敗する' do
          fill_in 'user[name]', with: '三島由紀夫'
          fill_in 'user[email]', with: 'mishima@example.com'
          attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/image/test-profile.gif"
          click_button '更新する'
          expect(current_path).to eq profile_path
          expect(page).to have_content('Avatar"gif"ファイルのアップロードは許可されていません。アップロードできるファイルタイプ: jpg, jpeg, png')
        end
      end
    end
  end
end
