class Shopper < ApplicationRecord
  has_many :sales, dependent: :restrict_with_exception
  belongs_to :user

  validates :name, presence: true, length: { minimum: 2 }
  validates :user, presence: true

  scope :ordered, -> (current_user) { where(user: current_user).order(:name) }

  paginates_per 10
end
