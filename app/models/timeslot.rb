class Timeslot < ApplicationRecord
  belongs_to :band
  belongs_to :event

  validates_associated :band
  validates_uniqueness_of :event_id, scope: [:band_id]
end
