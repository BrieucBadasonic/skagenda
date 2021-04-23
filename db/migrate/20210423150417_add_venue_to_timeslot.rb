class AddVenueToTimeslot < ActiveRecord::Migration[6.0]
  def change
    add_reference :timeslots, :event, null: false, foreign_key: true
  end
end
