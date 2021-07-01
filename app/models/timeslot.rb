class Timeslot < ApplicationRecord
  belongs_to :band
  belongs_to :event

  validates_uniqueness_of :band_id, scope: :event_id, message: "This band is already on that event"
end
