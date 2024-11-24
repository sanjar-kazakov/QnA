class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers
  has_many :badges
  has_many :votes

  def author?(resource)
    id == resource.user_id # self.id == ... то же самое
  end
end
