require 'rails_helper'

feature 'Author can delete his question', '
In order to delete a question
As an author of question
I want to be able to delete my question
' do
  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let(:question) { create(:question, user: author) }

  scenario 'Author can delete his question' do
    sign_in(author)
    visit question_path(question)
    click_on 'Delete Question'

    expect(current_path).to eq(questions_path)
    expect(page).to have_content('Your question has been deleted')
  end

  scenario 'User can not delete author\'s question' do
    sign_in(user)
    visit question_path(question)

    expect(page).not_to have_content('Delete Question')
  end
end