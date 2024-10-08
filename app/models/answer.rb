class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  scope :kept, -> { where(discarded_at: nil) }

  def soft_delete
    update(discarded_at: Time.current)
  end
end
