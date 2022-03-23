module LoginModule
  def login(user)
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    within('.login-form') do
      click_button 'ログインする'
    end
  end
end