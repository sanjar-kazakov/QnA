require 'rails_helper'

feature 'User can edit answer', '
In order to update answer
As an authenticated user
I would like to edit my answer
' do
  let(:author) { create :user }
  let(:user) { create :user }
  let!(:question) { create :question }
  let!(:answer) { create(:answer, question:, user: author) }

  describe 'Authenticated user', js: true do
    before do
      sign_in(author)
      sleep 1
      visit question_path(question)
    end

    scenario 'can edit his answer' do
      within '.answers' do
        click_on 'Edit answer'
        fill_in 'Your answer', with: 'Edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'gets error when trying to save an empty answer' do
      within '.answers' do
        click_on 'Edit answer'
        fill_in 'Your answer', with: ''
        click_on 'Save'

        expect(page).to have_content 'Body can\'t be blank'
      end
    end
  end

  scenario 'cannot edit someone else\'s answer', js: true  do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      expect(page).not_to have_link 'Edit answer'
    end
  end

  scenario 'unauthorized user cannot edit answer' do
    visit question_path(question)

    expect(page).not_to have_link 'Edit answer'
  end
end
