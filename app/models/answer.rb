class Answer < ApplicationRecord
  include Votable

  belongs_to :question
  belongs_to :user

  has_many :links, dependent: :destroy, as: :linkable

  has_many_attached :files
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  validates :body, presence: true

  scope :kept, -> { where(discarded_at: nil) }

  def soft_delete
    update(discarded_at: Time.current)
  end

  def mark_as_best
    question.update(best_answer_id: id)
    award_badge_to_user
  end

  private

  def award_badge_to_user
    user.badges << question.badge
  end
end
