class BookList < ApplicationRecord
  belongs_to :klub
  belongs_to :book
  has_many :ratings, dependent: :destroy

  def average_score
    ratings.average(:score)&.round(1)
  end

  validates :month, presence: true, inclusion: { in: 1..12 }
  validates :year,  presence: true, numericality: { greater_than: 2000 }
  validates :klub_id, uniqueness: { scope: [ :month, :year ], message: "already has a book scheduled for that month" }

  scope :chronological,  -> { order(year: :asc, month: :asc) }
  scope :reverse_chrono, -> { order(year: :desc, month: :desc) }
  scope :read,      -> { y, m = current_period; where("year < ? OR (year = ? AND month < ?)", y, y, m) }
  scope :scheduled, -> { y, m = current_period; where("year > ? OR (year = ? AND month >= ?)", y, y, m) }

  MONTHS = Date::MONTHNAMES.compact.freeze

  def period
    "#{MONTHS[month - 1]} #{year}"
  end

  def read?
    Date.new(year, month) < Date.today.beginning_of_month
  end

  def self.current_period
    [ Date.today.year, Date.today.month ]
  end
end
