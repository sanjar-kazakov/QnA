require 'rails_helper'

feature 'User can create question', '
In order to get answer from a community
As an authenticated user
I want to be able to ask a questions
' do
  given(:user) { create(:user) }
  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
      click_on 'New Question'
    end

    scenario 'can create a question' do
      fill_in 'Title', with: 'Question'
      fill_in 'Body', with: 'Lorem ipsum dolor sit amet'
      click_on 'Ask'

      expect(page).to have_content('Your question has been created')
      expect(page).to have_content('Question')
      expect(page).to have_content('Lorem ipsum dolor sit amet')
    end

    scenario 'creates a question with errors' do
      click_on 'Ask'

      expect(page).to have_content('Title can\'t be blank')
    end
  end

  scenario 'Non-authenticated user cannot create a question' do
    visit questions_path
    click_on 'New Question'

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
