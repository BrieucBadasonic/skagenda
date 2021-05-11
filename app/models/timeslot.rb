class Timeslot < ApplicationRecord
  belongs_to :band
  belongs_to :event

  validates_associated :band
end
