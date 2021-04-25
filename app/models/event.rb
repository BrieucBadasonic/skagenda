class Event < ApplicationRecord
  belongs_to :venue
  belongs_to :user
  has_many :timeslots
  has_many :bands, through: :timeslots
end
