require 'rails_helper'

feature 'User can create an answer', '
  In order to provide an answer to a question
  As an authenticated user
  I want to be able to submit an answer
' do
  let(:user) { create :user }
  let!(:question) { create :question }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
      click_on 'Show'
    end

    scenario 'can answer to the question', :js do
      fill_in 'Body', with: 'Test question'
      click_on 'Answer'

      # expect(page).to have_content 'Your answer has been submitted'
      within '.answers' do
        expect(page).to have_content 'Test question'
      end
    end

    scenario 'can add files to his answer while answering to the question', :js do
      fill_in 'Body', with: 'Test question'
      attach_file 'File', %W[#{Rails.root}/spec/rails_helper.rb #{Rails.root}/spec/spec_helper.rb]
      click_on 'Answer'

      within '.answers' do
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end

    scenario 'creates an answer with errors', :js do
      click_on 'Answer'

      expect(page).to have_content('Body can\'t be blank')
    end
  end

  scenario 'Non-authenticated user cannot create an answer' do
    visit question_path(question)
    click_on 'Answer'

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
