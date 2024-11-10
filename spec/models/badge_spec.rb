require 'rails_helper'

RSpec.describe Badge, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:badge) { create(:badge, question:, user:) }

  describe 'associations' do
    it 'belong to a question' do
      expect(badge.question).to eq(question)
    end

    it 'belongs to a user' do
      expect(badge.user).to eq(user)
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      badge = described_class.new(name: nil)
      expect(badge).to be_invalid
    end
  end

  describe 'storage' do
    it 'has an attachment' do
      expect(Badge.new.badge_image).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end


end
