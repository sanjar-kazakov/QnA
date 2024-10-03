class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  scope :kept, -> { where(discarded_at: nil) }

  def soft_delete
    update(discarded_at: Time.current)
  end
end
