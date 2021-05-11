class Venue < ApplicationRecord
  has_many :events

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2 }
end
