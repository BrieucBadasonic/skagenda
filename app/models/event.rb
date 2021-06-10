class Event < ApplicationRecord
  belongs_to :venue
  belongs_to :user
  has_many :timeslots, dependent: :destroy
  has_many :bands, through: :timeslots
  has_one_attached :photo

  accepts_nested_attributes_for :bands

  validates :date, :price, presence: true
  validates_uniqueness_of :date, scope: :venue_id

  scope :active, -> { where('date > ?', Time.now.to_date) }

  def confirm?
    confirm
  end
end
