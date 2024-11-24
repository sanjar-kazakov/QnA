require 'rails_helper'

feature 'User can add links to answer', '
In order to provide an additional info to the answer
As an author of the answer
I want to be able to add links to answer
' do
  let(:user) { create :user }
  let(:question) { create :question }
  let(:gist_url) { 'https://gist.github.com' }

  describe 'Authenticated user', :js do
    before do
      sign_in(user)
      sleep 1
      visit question_path(question)
    end

    scenario 'can add links to answer', :js do
      fill_in 'Body', with: 'Lorem ipsum dolor sit amet'

      click_on 'Add link'

      fill_in 'Link name', with: 'My Link'
      fill_in 'Url', with: gist_url

      click_on 'Answer'
      visit current_path
      within '.answers' do
        expect(page).to have_link 'My Link', href: gist_url
      end
    end
  end
end
