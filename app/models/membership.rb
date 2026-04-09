class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :klub

  validates :user_id, uniqueness: { scope: :klub_id, message: "is already a member of this klub" }
  validates :role, inclusion: { in: %w[member admin] }
end
