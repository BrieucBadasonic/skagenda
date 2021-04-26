class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @venue = Venue.new
    @event.bands.build
  end

  def create
    @event = Event.new(event_params)
  end
end
