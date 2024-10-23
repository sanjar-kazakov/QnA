require 'rails_helper'

feature 'User can mark answers as best', '
In order to mark answers as best
As an authenticated user
I want to mark answers as best
' do
  let(:user) { create :user }
  let(:author) { create :user }
  let!(:question) { create :question, user: author }
  let!(:answer) { create :answer, question: question }

  describe 'Authenticated author', js: true do
    before do
      sign_in(author)
      sleep 2
      visit question_path(question)
      sleep 2
    end

    scenario 'can mark answer as best' do
      save_and_open_page
      within '.answers' do
        click_on 'Mark as best answer'

        expect(page).to have_content 'Best answer:'
      end
    end
  end
end