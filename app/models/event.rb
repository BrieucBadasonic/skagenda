class Event < ApplicationRecord
  belongs_to :venue, autosave: true
  belongs_to :user
  has_many :timeslots, dependent: :destroy
  has_many :bands, through: :timeslots
  has_one_attached :photo

  accepts_nested_attributes_for :bands

  validates :date, :price, presence: true
  validates_uniqueness_of :date, scope: :venue_id, message: "Venue already has an event that date"

  scope :active, -> { where('date >= ?', Time.now.to_date) }

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :organisateur, :date ],
    associated_against: {
      venue: [ :name ],
      bands: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }

  def confirm?
    confirm
  end
end
