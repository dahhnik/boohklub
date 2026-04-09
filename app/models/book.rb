class Book < ApplicationRecord
  has_many :book_lists, dependent: :destroy
  has_many :klubs, through: :book_lists

  validates :title, presence: true
  validates :author, presence: true
  validates :goodreads_url, format: { with: /\Ahttps?:\/\/.+/, message: "must be a valid URL" }, allow_blank: true

  def display_name
    "#{title} — #{author}"
  end
end
