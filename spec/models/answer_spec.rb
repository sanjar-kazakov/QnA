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

  describe 'storage' do
    it 'has many attachments' do
      expect(Answer.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end
end
