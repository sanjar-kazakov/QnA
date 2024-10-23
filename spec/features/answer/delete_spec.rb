require 'rails_helper'

feature 'Author can delete his answer', '
In order to delete an answer
As an author of an answer
I want to be able to delete my answer
' do
  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let!(:question) { create(:question, user:) }
  let!(:answer) { create(:answer, question:, user: author) }

  scenario 'Author can delete his answer', :js do
    sign_in(author)
    sleep 2
    visit question_path(question)

    within '.answers' do
      click_on 'Delete answer'

      page.accept_alert 'Are you sure?'

      expect(page).not_to have_content(answer.body)
    end
  end

  scenario 'User can not delete author\'s answer' do
    sign_in(author)
    visit question_path(question)

    expect(page).not_to have_content('Delete Answer')
  end
end
