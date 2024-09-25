require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do
    it 'belongs to a question' do
      answer = create(:answer)
      question = answer.question
      expect(answer.question).to eq(question)
    end
  end

  describe 'validations' do
    it 'validates presence of body' do
      answer = described_class.new(body: nil)
      expect(answer).to be_invalid
    end
  end
end
