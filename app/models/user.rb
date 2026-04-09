class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :klubs, through: :memberships
  has_many :ratings, dependent: :destroy

  enum :role, { member: "member", admin: "admin" }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def full_name
    [ first_name, last_name ].compact_blank.join(" ").presence || email_address
  end
end
