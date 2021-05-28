class BandsController < ApplicationController
  # def create
  #   # create new bands if they are not found in the DB
  #   # create timeslot with the band for the event and link it to the new event
  #   event_params[:bands_attributes].each do |band|
  #     @ts = Timeslot.new
  #     @ts.event = @event
  #     if Band.where(name: band[1][:name]).empty?
  #       @band = Band.new(name: band[1][:name])
  #       @band.save!
  #     else
  #       @band = Band.where(name: band[1][:name])[0]
  #     end
  #     @ts.band = @band
  #     authorize @ts
  #     @ts.save!
  #   end
  # end
end
