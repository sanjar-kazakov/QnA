module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in_credentials(user)
    click_on 'Log in'
  end

  def sign_up(user)
    visit new_user_registration_path
    fill_in_credentials(user, password_confirmation: true)
    click_on 'Sign up'
  end

  def fill_in_credentials(creds, password_confirmation: false)
    fill_in 'Email', with: creds.email
    fill_in 'Password', with: creds.password
    return unless password_confirmation && page.has_field?('Password confirmation')

    fill_in 'Password confirmation', with: creds.password
  end
end
