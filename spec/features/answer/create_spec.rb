require 'rails_helper'

feature 'User can create an answer', '
  In order to provide an answer to a question
  As an authenticated user
  I want to be able to submit an answer
' do
  let!(:user) { create :user }
  let!(:question) { create :question }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
      save_and_open_page
      click_on @question.title
    end

    scenario 'can answer to the question' do
      fill_in 'Body', with: 'Vitalik gey'
      click_on 'Answer'

      expect(page).to have_content 'Your answer has been submitted'
      expect(page).to have_content 'Vitalik gey'
    end
  end
end
