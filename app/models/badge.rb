class Badge < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :question

  has_one_attached :badge_image, dependent: :destroy

  validates :name, presence: true

  scope :kept, -> { where(discarded_at: nil) }

  def soft_delete
    update(discarded_at: Time.zone.now)
  end
end
