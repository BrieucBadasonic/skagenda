

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :skip_authorization, only: :index
  before_action :find_event, only: [:edit, :update, :destroy, :confirmed]
  def index
    @events = policy_scope(Event).where('date > ?' ,Time.now.to_date).order(date: :asc)
  end

  def confirmation
    @events = policy_scope(Event).where('date > ?' ,Time.now.to_date).order(date: :asc)
    authorize @events
  end

  def confirmed
    @event.confirm = true
    @event.save
    redirect_to confirmation_events_path, notice: "Event was successfully confirmed"
  end

  def new
    @event = Event.new
    authorize @event
    @venue = Venue.new
    authorize @venue
    @event.bands.build
  end

  def create
    # Create a new venue if the venue enter by the user is not found in the DB
    if Venue.where(name: event_params[:venues][:name]).empty?
      @venue = Venue.new(event_params[:venues])
      authorize @venue
      @venue.save!
    else
      @venue = Venue.where(name: event_params[:venues][:name])[0]
    end

    # create the new event and add the current user to it
    @event = Event.new(date: event_params[:date], price: event_params[:price], photo: event_params[:photo])
    @event.user = current_user
    @event.venue = @venue

    # create new bands if they are not found in the DB
    # create timeslot with the band for the event and link it to the new event
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
      authorize @ts
      @ts.save!
    end

    #  authorize the event in pundit, save it and redirect
    authorize @event
    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
    @venue = Venue.find(params[:venue_id])
    authorize @event
    authorize @venue
  end

  def update
    # check if there is a new phot in the params
    # update with the new photo or keep the old one if there is no new one
    if params[:event].has_key?("photo")
      if @event.update(date: event_params[:date], price: event_params[:price], photo: event_params[:photo])
        redirect_to events_path, notice: "Event was successfully updated"
      end
    else
      @event.update(date: event_params[:date], price: event_params[:price])
      redirect_to events_path, notice: "Event was successfully updated"
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted"
  end

  private

  def event_params
    params.require(:event).permit(:date, :price, :photo, venues: [:name, :address], bands_attributes: [:name])
  end

  def find_event
    @event = Event.find(params[:id])
    authorize @event
  end
end
