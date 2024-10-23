require 'rails_helper'

feature 'User can mark answers as best', '
In order to mark answers as best
As an authenticated user
I want to mark answers as best
' do
  let(:user) { create :user }
  let(:author) { create :user }
  let!(:question) { create :question, user: author }
  let!(:answer) { create :answer, question: }

  describe 'Authenticated user', :js do
    before do
      sign_in(author)
      sleep 1
      visit question_path(question)
    end

    scenario 'can mark answer for his question as best' do
      within '.answers' do
        click_on 'Mark as best answer'

        expect(page).to have_content 'Best answer:'
      end
    end
  end

  describe 'Authenticated user', :js do
    before do
      sign_in(user)
      sleep 1
      visit question_path(question)
    end

    scenario 'can not mark answer for another user\'s question', :js do
      within '.answers' do
        expect(page).not_to have_link 'Mark as best answer'
      end
    end
  end

  scenario 'Unauthenticated user cannot see Mark as best answer button', :js do
    visit question_path(question)

    within '.answers' do
      expect(page).not_to have_link 'Mark as best answer'
    end
  end
end
