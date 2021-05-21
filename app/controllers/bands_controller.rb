class BandsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @band_names = params[:bandNames]

    @band_names.each do |name|
      timeslot = Timeslot.find_by(event: @event, band: @band)
      @band = Band.find_by(name: name)
      @ts = Timeslot.new
      @ts.event = @event
      authorize @band
      if timeslot.blank?
        raise
        @ts.band = @band
      elsif !@band.nil?
        @band = Band.new(name: name)
        @band.save
        @ts.band = @band
      else
        ts = timeslot
        ts.destroy
      end
      @ts.save
    end
    redirect_to events_path(@event)
  end
end
