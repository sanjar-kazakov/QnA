require 'rails_helper'

feature 'User can sign out', '
As authenticated user
I would like to be able to sign out
' do
  given(:user) { create(:user) }

  scenario 'Authenticated user tries to sign out' do
    sign_in(user)
    visit questions_path
    click_on 'Sign Out'

    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Redirects to login page after sign out' do
    sign_in(user)
    visit questions_path
    click_on 'Sign Out'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'Non-authenticated user doe not see sign out link' do
    visit questions_path

    expect(page).not_to have_link 'Sign Out'
  end
end
