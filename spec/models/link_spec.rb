require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      link = build(:link, name: nil)
      expect(link).not_to be_valid
      expect(link.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of url' do
      link = build(:link, url: nil)
      expect(link).not_to be_valid
      expect(link.errors[:url]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to linkable' do
      question = create(:question)
      link = create(:link, linkable: question)
      expect(link.linkable).to eq(question)
    end
  end
end
