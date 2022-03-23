require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ユーザー登録機能' do
    before do
      visit new_user_path
    end
    context '全ての入力値が正常' do
      it 'ユーザー登録に成功する' do
        fill_in 'user[name]', with: '銭湯 二郎'
        fill_in 'user[email]', with: 'jiro@example.com'
        fill_in 'user[password]', with: 'jirosauna123'
        fill_in 'user[password_confirmation]', with: 'jirosauna123'
        click_button '登録する'
        expect(current_path).to eq profile_path
        expect(page).to have_content('銭湯 二郎')
      end
    end
    context '名前が入力されていない' do
      it '登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: 'jiro@example.com'
        fill_in 'user[password]', with: 'jirosauna123'
        fill_in 'user[password_confirmation]', with: 'jirosauna123'
        click_button '登録する'
        expect(current_path).to eq users_path
        expect(page).to have_content('ユーザー名を入力してください')
      end
    end
    context 'メールアドレスが入力されていない' do
      it '登録に失敗する' do
        fill_in 'user[name]', with: '銭湯 二郎'
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: 'jirosauna123'
        fill_in 'user[password_confirmation]', with: 'jirosauna123'
        click_button '登録する'
        expect(current_path).to eq users_path
        expect(page).to have_content('メールアドレスを入力してください')
      end
    end
    context 'パスワードが入力されていない' do
      it '登録に失敗する' do
        fill_in 'user[name]', with: '銭湯 二郎'
        fill_in 'user[email]', with: 'jiro@example.com'
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: 'jirosauna123'
        click_button '登録する'
        expect(current_path).to eq users_path
        expect(page).to have_content('パスワードは6文字以上で入力してください')
      end
    end
    context 'パスワード（確認用）が入力されていない' do
      it '登録に失敗する' do
        fill_in 'user[name]', with: '銭湯 二郎'
        fill_in 'user[email]', with: 'jiro@example.com'
        fill_in 'user[password]', with: 'jirosauna123'
        fill_in 'user[password_confirmation]', with: ''
        click_button '登録する'
        expect(current_path).to eq users_path
        expect(page).to have_content('パスワード（確認用）を入力してください')
      end
    end
    context 'メールアドレスが重複している' do
      it '登録に失敗する' do
        existed_user = create(:user)
        fill_in 'user[name]', with: '銭湯 二郎'
        fill_in 'user[email]', with: existed_user.email
        fill_in 'user[password]', with: 'jirosauna123'
        fill_in 'user[password_confirmation]', with: 'jirosauna123'
        click_button '登録する'
        expect(current_path).to eq users_path
        expect(page).to have_content('メールアドレスはすでに存在します')
      end
    end
    context 'パスワードが6文字未満' do
      it '登録に失敗する' do
        fill_in 'user[name]', with: '銭湯 二郎'
        fill_in 'user[email]', with: 'jiro@example.com'
        fill_in 'user[password]', with: 'jiro'
        fill_in 'user[password_confirmation]', with: 'jiro'
        click_button '登録する'
        expect(current_path).to eq users_path
        expect(page).to have_content('パスワードは6文字以上で入力してください')
      end
    end
  end
end
