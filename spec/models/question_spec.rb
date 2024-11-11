require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question, user:) }

  describe 'associations' do
    it 'has many answers' do
      create_list(:answer, 2, question:, user:)

      expect(question.answers.count).to eq(2)
    end

    it 'has many links' do
      create_list(:link, 2, linkable: question)
      expect(question.links.count).to eq(2)
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
      expect(described_class.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end

  describe 'nested attributes' do
    it 'accepts nested attributes for links' do
      link_attributes = [{ name: 'Example link', url: 'http://example.com' }]
      question_with_links = described_class.new(title: 'Test title', body: 'Test body', user:, links_attributes: link_attributes)

      expect(question_with_links.links.size).to eq(1)
      expect(question_with_links.links.first.name).to eq('Example link')
      expect(question_with_links.links.first.url).to eq('http://example.com')
    end

    it 'accepts nested attributes for badge' do
      badge_attributes = { name: 'Sample Badge' }
      question = described_class.new(title: 'Test title', body: 'Test body', user:, badge_attributes: badge_attributes)

      expect(question.badge).not_to be_nil
      expect(question.badge.name).to eq('Sample Badge')
    end
  end
end
