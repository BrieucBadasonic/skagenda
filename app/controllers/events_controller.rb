class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :skip_authorization, only: :index
  before_action :find_event, only: [:edit, :update, :destroy, :confirmed, :update_venue]

  def index
    @events = policy_scope(Event).active.order(date: :asc)
  end

  def confirmation
    @events = policy_scope(Event).active.order(date: :asc)
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
    # create the new event and add the current user to it
    @event = Event.new(date: event_params[:date], price: event_params[:price], photo: event_params[:photo])
    @event.user = current_user

    # calling 2 private method to check venue and band
    # associate an existing venue/band to the event or create a new one
    checking_venue
    checking_band
    @event.save!

    #  authorize the event in pundit, save it and redirect
    authorize @event
    redirect_to events_path, notice: "Event was successfully created" if @event.save
  end

  def edit
    @venue = Venue.find(params[:venue_id])
    authorize @venue
    @event.bands.build
  end

  def update
    # check if there is a new phot in the params
    # update with the new photo or keep the old one if there is no new one
    update_venue
    update_bands
    destroy_timeslot
    if params[:event].has_key?("photo")
      @event.update(date: event_params[:date], price: event_params[:price], photo: event_params[:photo])
    else
      @event.update(date: event_params[:date], price: event_params[:price])
    end
    redirect_to events_path, notice: "Event was successfully updated"
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted"
  end

  private

  def event_params
    params.require(:event).permit(:date, :price, :photo, :venue_id, band_ids: [], venue: [:name, :address], bands_attributes: [:id, :name])
  end

  def find_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def checking_venue
    # A venue was selected
    # venue = Venue.find_or_initialize_by(name: event_params[:venue][:name],
    #                                     address: event_params[:venue][:address])
    if event_params[:venue_id] == ""
      venue = Venue.new(event_params[:venue])
    else
      venue_id = event_params[:venue_id]
      venue = Venue.find(venue_id)
    end
    @event.venue = venue
  end

  def checking_band
    # band stuff
    # selected bands
    event_params[:band_ids].reject(&:empty?).each do |band_id|
      band = Band.find(band_id.to_i)
      @event.bands << band
    end

    # non existing bands
    event_params[:bands_attributes].to_unsafe_h.each do |key|
      band_name = key[1][:name]
      @event.bands.build(name: band_name)
    end
  end
end
