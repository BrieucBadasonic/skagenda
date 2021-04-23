class Event < ApplicationRecord
  belongs_to :venue
  belongs_to :user
  has_many :timeslot
end
