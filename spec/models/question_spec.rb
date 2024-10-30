require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question, user:) }

  describe 'associations' do
    it 'has many answers' do
      create_list(:answer, 2, question:, user:)

      expect(question.answers.count).to eq(2)
    end
  end

  describe 'validations' do
    it 'validates presence of title' do
      question = described_class.new(body: '123')
      expect(question).to be_invalid
    end

    it 'validates presence of body' do
      question = described_class.new(title: '123')
      expect(question).to be_invalid
    end
  end

  describe 'storage' do
    it 'has many attachments' do
      expect(Question.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end
end
