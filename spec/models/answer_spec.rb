require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question:) }

  describe 'associations' do
    it 'belongs to a question' do
      expect(answer.question).to eq(question)
    end

    it 'has many links' do
      create_list(:link, 2, linkable: answer)
      expect(answer.links.count).to eq(2)
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

  describe 'nested attributes' do
    it 'accepts nested attributes for links' do
      link_attributes = [{ name: 'Example link', url: 'http://example.com' }]
      answer_with_links = described_class.new( body: 'Test body', links_attributes: link_attributes)

      expect(answer_with_links.links.size).to eq(1)
      expect(answer_with_links.links.first.name).to eq('Example link')
      expect(answer_with_links.links.first.url).to eq('http://example.com')
    end
  end
end
