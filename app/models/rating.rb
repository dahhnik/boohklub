class Rating < ApplicationRecord
  belongs_to :book_list
  belongs_to :user

  validates :score, presence: true, inclusion: { in: 1..5, message: "must be between 1 and 5" }
  validates :user_id, uniqueness: { scope: :book_list_id }
end
