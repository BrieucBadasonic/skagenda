class Band < ApplicationRecord
  has_many :timeslots
  has_many :events, through: :timeslots
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 3 }
end
