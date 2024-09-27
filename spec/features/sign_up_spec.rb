require 'rails_helper'

feature 'User can sign up', '
As an unregistered user
I would like to be able to sign up
' do
  let(:user) { build(:user) }
  let(:invalid_creds) { build(:user, email: 'kjdscd', password: 'passw') }
  let(:empty_creds) { build(:user, email: '', password: '') }

  scenario 'User is able to sign up with valid creds' do
    sign_up(user)

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  describe 'User is not able to sign up' do
    before { visit new_user_registration_path }

    scenario 'with invalid email and password' do
      fill_in_credentials(invalid_creds)
      click_on 'Sign up'

      expect(page).to have_content 'Email is invalid'
      expect(page).to have_content 'Password is too short (minimum is 6 characters)'
    end

    scenario 'with empty email and password' do
      fill_in_credentials(empty_creds)
      click_on 'Sign up'

      expect(page).to have_content 'Email can\'t be blank'
      expect(page).to have_content 'Password can\'t be blank'
    end

    scenario 'if this user already registered' do
      user = create(:user)
      sign_up(user)

      expect(page).to have_content 'Email has already been taken'
    end
  end
end
