require 'rails_helper'

feature 'Author can delete his answer', '
In order to delete an answer
As an author of an answer
I want to be able to delete my answer
' do
  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question:, user: author) }

  scenario 'Author can delete his answer' do
    sign_in(author)
    visit question_path(question)

    click_on 'Delete Answer'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content('Your answer has been deleted')
  end

  scenario 'User can not delete author\'s answer' do
    sign_in(user)
    visit question_path(question)

    expect(page).not_to have_content('Delete Answer')
  end
end