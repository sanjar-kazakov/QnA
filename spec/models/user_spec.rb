require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:answer_author) { create(:user) }
  let(:question) { create(:question, user:) }
  let(:answer) { create(:answer, question:, user: answer_author) }

  describe 'validations' do
    it 'validates presence of email' do
      user = described_class.new(email: '')
      expect(user).not_to be_valid
    end

    it 'validates presence of password' do
      user = described_class.new(password: '')
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many questions' do
      create_list(:question, 3, user:)

      expect(user.questions.count).to eq(3)
    end
  end

  describe 'is_author?' do
    it 'is true' do
      expect(user.is_author?(question)).to be true
    end

    it 'is false' do
      expect(user.is_author?(answer)).to be false
    end
  end
end
