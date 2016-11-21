include ApplicationHelper

def log_in_as(user, capybara: true, remember_me: '0')
  if capybara
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    check 'Remember me' if remember_me == '1'
    click_button 'Log in'
  else
    post login_path, params: {session: {email: user.email, password: user.password, remember_me: remember_me}}
  end
end

