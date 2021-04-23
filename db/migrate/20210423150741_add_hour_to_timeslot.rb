class AddHourToTimeslot < ActiveRecord::Migration[6.0]
  def change
    add_column :timeslots, :hour, :date
  end
end
