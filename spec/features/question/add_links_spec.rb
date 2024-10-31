require 'rails_helper'

feature 'User can add links to question', '
In order to provide an additional info to the question
As an author of the question
I want to be able to add links to question
' do
  let(:user) { create :user }
  let(:gist_url) { 'https://gist.github.com' }

  scenario 'User can add links to question', :js do
    sign_in(user)
    sleep 1
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Lorem ipsum dolor sit amet'

    fill_in 'Link name', with: 'My Link'
    fill_in 'Url', with: gist_url

    click_on 'Ask'

    expect(page).to have_link 'My Link', href: gist_url
  end
end
