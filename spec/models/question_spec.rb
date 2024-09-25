require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations' do
    it 'has many answers' do
      question = create(:question)
      create(:answer, question:)
      create(:answer, question:)
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
end
