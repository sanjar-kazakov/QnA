require 'rails_helper'

feature 'User can edit question', '
In order to update question
As an authenticated user
I would like to edit my question
' do
  let(:author) { create :user }
  let(:user) { create :user }
  let!(:question) { create(:question, user: author) }

  describe 'Authenticated user', :js do
    before do
      sign_in(author)
      sleep 1
      visit question_path(question)
    end

    scenario 'can edit his question' do
      within '.question' do
        click_on 'Edit'
        sleep 1
        fill_in 'Title', with: 'Edited title'
        fill_in 'Body', with: 'Edited body'
        click_on 'Save'

        expect(page).not_to have_content question.title
        expect(page).not_to have_content question.body
        expect(page).to have_content 'Edited title'
        expect(page).to have_content 'Edited body'
        expect(page).not_to have_selector 'textarea'
      end
    end

    scenario 'gets errors while updating his question' do
      within '.question' do
        click_on 'Edit'
        fill_in 'Title', with: ''
        fill_in 'Body', with: ''
      end

      click_on 'Save'

      expect(page).to have_content 'Title can\'t be blank'
      expect(page).to have_content 'Body can\'t be blank'
    end
  end

  scenario 'cannot edit someone else\'s question', :js do
    sign_in(user)
    visit question_path(question)

    expect(page).not_to have_button 'Edit'
  end

  scenario 'unauthenticated user cannot edit question' do
    visit question_path(question)

    expect(page).not_to have_button 'Edit'
  end
end
