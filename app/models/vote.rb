class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :value, inclusion: { in: [-1, 1] }
  validates :user, uniqueness: { scope: %i[votable_id votable_type], message: 'can vote only once per item' }
end
