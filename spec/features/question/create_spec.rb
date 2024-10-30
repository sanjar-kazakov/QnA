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

    scenario 'can ask a question' do
      fill_in 'Title', with: 'Question'
      fill_in 'Body', with: 'Lorem ipsum dolor sit amet'
      click_on 'Ask'

      expect(page).to have_content('Your question has been created')
      expect(page).to have_content('Question')
      expect(page).to have_content('Lorem ipsum dolor sit amet')
    end

    scenario 'asks a question with errors' do
      click_on 'Ask'

      expect(page).to have_content('Title can\'t be blank')
    end

    scenario 'asks a question with attached file' do
      fill_in 'Title', with: 'Question'
      fill_in 'Body', with: 'Lorem ipsum dolor sit amet'

      attach_file 'File', %W[#{Rails.root}/spec/rails_helper.rb #{Rails.root}/spec/spec_helper.rb]
      click_on 'Ask'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  scenario 'Non-authenticated user cannot ask a question' do
    visit questions_path
    click_on 'New Question'

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
