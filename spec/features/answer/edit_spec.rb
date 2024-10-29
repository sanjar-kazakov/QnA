require 'rails_helper'

feature 'User can edit answer', '
In order to update answer
As an authenticated user
I would like to edit my answer
' do
  let(:author) { create :user }
  let(:user) { create :user }
  let!(:question) { create :question }
  let!(:answer) { create(:answer, :with_files, question:, user: author) }

  describe 'Authenticated user', :js do
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

        expect(page).not_to have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).not_to have_selector 'textarea'
      end
    end

    scenario 'can attach file during answer update' do
      within '.answers' do
        click_on 'Edit answer'
        attach_file 'File', %W[#{Rails.root}/spec/spec_helper.rb]
        click_on 'Save'
        sleep 1

        expect(answer.files.count).to eq(3)
      end
    end

    scenario 'can delete his answer\'s file' do
      within '.answers' do
        first(:button, 'Remove file').click
        page.accept_alert 'Are you sure?'
        sleep 1

        expect(answer.files.count).to eq(1)
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

  scenario 'cannot edit someone else\'s answer', :js do
    sign_in(user)
    sleep 1
    visit question_path(question)

    within '.answers' do
      expect(page).not_to have_link 'Edit answer'
    end
  end

  describe 'Unauthorized user' do
    before do
      sleep 1
      visit question_path(question)
    end

    scenario 'can see question answer' do
      within '.answers' do
        expect(page).to have_content answer.body
      end
    end

    scenario 'cannot edit answer' do
      expect(page).not_to have_link 'Edit answer'
    end
  end
end
