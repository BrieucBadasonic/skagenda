class EventsController < ApplicationController

  def index
    @events = Event.all
    @events.each do |event|
      event.timeslots
    end
  end
end
