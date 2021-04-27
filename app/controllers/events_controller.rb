class EventsController < ApplicationController
skip_before_action :authenticate_user!, only: [ :index ]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @venue = Venue.new
    # @event.venue.build
    @event.bands.build
  end

  def create
    if Venue.where(name: event_params[:venues][:name]).empty?
      @venue = Venue.new(event_params[:venues])
      @venue.save!
    else
      @venue = Venue.where(name: event_params[:venues][:name])[0]
    end

    @event = Event.new(date: event_params[:date], price: event_params[:price])
    @event.user = current_user
    @event.venue = @venue
    @event.save!

    event_params[:bands_attributes].each do |band|
      @ts = Timeslot.new
      @ts.event = @event
      if Band.where(name: band[1][:name]).empty?
        @band = Band.new(name: band[1][:name])
        @band.save!
      else
        @band = Band.where(name: band[1][:name])[0]
      end
      @ts.band = @band
      @ts.save!
    end
  end

  private

  def event_params
    params.require(:event).permit(:date, :price, venues: [:name, :address], bands_attributes: [:name])
  end
end
# , :bands_attributes[:name]
# params[:event][:bands_attributes].keys.count
