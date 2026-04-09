class Klub < ApplicationRecord
  ACTIVITY_TYPES = %w[books crafts].freeze

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :book_lists, dependent: :destroy
  has_many :books, through: :book_lists

  validates :name, presence: true
  validates :activity_type, inclusion: { in: ACTIVITY_TYPES }

  def admin?(user)
    memberships.exists?(user: user, role: "admin")
  end

  def member?(user)
    memberships.exists?(user: user)
  end
end
