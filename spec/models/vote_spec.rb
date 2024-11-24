require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:user) { create(:user) }
  let(:votable) { create(:question) }
  let(:vote) { create(:vote, user:, votable:) }

  describe 'associations' do
    it 'belongs to a user' do
      expect(vote.user).to eq(user)
    end

    it 'belongs to a votable' do
      expect(vote.votable).to eq(votable)
    end
  end

  describe 'validations' do
    it 'requires a user' do
      vote.user = nil
      expect(vote).not_to be_valid
    end

    it 'requires a votable' do
      vote.votable = nil
      expect(vote).not_to be_valid
    end

    it 'requires a value' do
      vote.value = nil
      expect(vote).not_to be_valid
    end

    it 'requires a valid value' do
      vote.value = 0
      expect(vote).not_to be_valid
    end
  end

  describe 'uniqueness' do
    before do
      vote
    end

    it 'does not allow user to vote more than once' do
      second_vote = build(:vote, user:, votable:)
      expect(second_vote).not_to be_valid
      expect(second_vote.errors.messages).to eq(user: ['can vote only once per item'])
    end
  end
end
