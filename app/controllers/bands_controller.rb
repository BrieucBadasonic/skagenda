class BandsController < ApplicationController
  def create
    # find the event we are working on in the DB
    event = Event.find(params[:event_id])
    # extract the band names array from the params
    band_names = params[:bandNames]

    # loop thru the band_names array
    band_names.each do |name|
      # find the band in the DB
      band = Band.find_by(name: name)
      # find th time slot in the DB (it's possible there is no time slot to find)
      timeslot = Timeslot.find_by(event: event, band: band)

      # create a new timeslot and attach it to the current event
      ts = Timeslot.new
      ts.event = event

      authorize band unless band.nil?

      # if timeslot is not existing and the band exist
      # we attach the band to the new timeslot
      if timeslot.blank? && !band.nil?
        ts.band = band
      # if the band does not exist
      # we create a new band and attach it to the new timeslot
      elsif band.nil?
        band = Band.new(name: name)
        authorize band
        band.save
        ts.band = band
      end
      ts.save
      destroy_unused_timeslot(event, band_names)
    end
    redirect_to events_path
  end

  private

  def destroy_unused_timeslot(event, band_names)
    # make an array with all the timeslot connected to this event
    timeslot_array = Timeslot.where(event: event)
    timeslot_array.each do |ts|
      # destroy timeslot if timeslot_band_name is not include in the bands names array
      ts.destroy unless band_names.include?(ts.band.name)
    end
  end
end
