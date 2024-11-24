require 'rails_helper'

RSpec.shared_examples_for 'votable' do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:votable) { create(described_class.to_s.underscore.to_sym) }

  describe '#vote_by' do
    it 'allows user to upvote' do
      expect { votable.vote_by(user, 1) }.to change { votable.votes.count }.by(1)
      expect(votable.votes.last.user_id).to eq(user.id)
      expect(votable.votes.last.value).to eq(1)
    end

    it 'allows user to down-vote' do
      expect { votable.vote_by(user, -1) }.to change { votable.votes.count }.by(1)
      expect(votable.votes.last.user_id).to eq(user.id)
      expect(votable.votes.last.value).to eq(-1)
    end

    it 'does not allow user to vote more than once' do
      votable.vote_by(user, 1)
      expect { votable.vote_by(user, -1) }.not_to(change { votable.votes.count })
    end
  end

  describe '#unvote_by!' do
    it 'allows user to remove their vote' do
      votable.vote_by(user, 1)
      expect { votable.unvote_by(user) }.to change { votable.votes.count }.by(-1)
      expect(votable).not_to be_voted_by(user)
    end

    it 'does nothing if the user has not voted' do
      expect { votable.unvote_by(user) }.not_to(change { votable.votes.count })
    end
  end

  describe '#voted_by?' do
    it 'returns true if the user has voted' do
      votable.vote_by(user, 1)
      expect(votable).to be_voted_by(user)
    end

    it 'returns false if the user has not voted' do
      expect(votable).not_to be_voted_by(user)
    end
  end

  describe '#rating' do
    it 'returns correct rating after upvote and down-vote' do
      votable.vote_by(user, 1)
      votable.vote_by(another_user, -1)
      expect(votable.rating).to eq(0)
    end

    it 'returns correct sum of votes' do
      votable.vote_by(user, 1)
      votable.vote_by(another_user, 1)
      expect(votable.rating).to eq(2)
    end
  end
end
