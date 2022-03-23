require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  describe 'ログイン機能' do
    let(:user) { create(:user) }
    describe 'ログイン前' do
      before do
        visit login_path
      end
      context '全ての入力値が正常' do
        it 'ログインに成功する' do
          fill_in 'email', with: user.email
          fill_in 'password', with: 'password'
          within('.login-form') do
            click_button 'ログインする'
          end
          expect(current_path).to eq profile_path
          expect(page).to have_content(user.name)
        end
      end
      context 'メールアドレスが未入力' do
        it 'ログインに失敗する' do
          fill_in 'email', with: ''
          fill_in 'password', with: 'password'
          within('.login-form') do
            click_button 'ログインする'
          end
          expect(current_path).to eq login_path
        end
      end
      context 'パスワードが未入力' do
        it 'ログインに失敗する' do
          fill_in 'email', with: user.email
          fill_in 'password', with: ''
          within('.login-form') do
            click_button 'ログインする'
          end
          expect(current_path).to eq login_path
        end
      end
    end
    describe 'ログイン後' do
      before do
        login(user)
      end
      context 'ログアウトボタンを押す' do
        it 'ログアウトに成功する' do
          click_button 'ログアウト'
          expect(current_path).to eq root_path
        end
      end
    end
  end
end
