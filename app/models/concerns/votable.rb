module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def rating
    votes.sum(:value)
  end

  def vote_by(user, value)
    votes.create(user:, value:)
  end

  def unvote_by(user)
    votes.where(user:).destroy_all
  end

  def voted_by?(user)
    votes.exists?(user:)
  end
end
