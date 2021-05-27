class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :skip_authorization, only: :index
  before_action :find_event, only: [:edit, :update, :destroy, :confirmed, :update_venue]
  def index
    @events = policy_scope(Event).where('date > ?', Time.now.to_date).order(date: :asc)
  end

  def confirmation
    @events = policy_scope(Event).where('date > ?', Time.now.to_date).order(date: :asc)
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
    if Venue.where(name: event_params[:venue_attributes][:name]).empty?
      @venue = Venue.new(event_params[:venue_attributes])
      authorize @venue
      @venue.save!
    else
      @venue = Venue.where(name: event_params[:venue][:name])[0]
    end

    # create the new event and add the current user to it
    @event = Event.new(date: event_params[:date], price: event_params[:price], photo: event_params[:photo])
    @event.user = current_user
    @event.venue = @venue

    create_band

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
    redirect_to events_path
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted"
  end

  private

  def event_params
    params.require(:event).permit(:date, :price, :photo,
                                  venue_attributes: [:name, :address],
                                  bands_attributes: [:id, :name])
  end

  def find_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def create_band
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
  end

  def update_venue
    return if event_params[:venue_attributes][:name] == ""
    return unless event_params.key?("venue_attributes")

    if Venue.where(name: event_params[:venue_attributes][:name]).exists?
      @venue = Venue.where(name: event_params[:venue_attributes][:name])[0]
    else
      @venue = Venue.new(name: event_params[:venue_attributes][:name],
                         address: event_params[:venue_attributes][:address])
      @venue.save!
    end
    @event.venue = @venue
  end

  def update_bands
    # iterate thru all the band in the params
    event_params[:bands_attributes].to_unsafe_h.each do |band|
      # create a new TS and associate it with the event we are working on
      @ts = Timeslot.new
      @ts.event = @event

      # check if the band exist in DB
      if Band.where(name: band.last[:name]).exists?
        @band = Band.where(name: band.last[:name])[0]
        # if TRUE --> check if there is a TS with that band and the venue
        #   UNLESS --> create a TS with tha band and the venue
        @ts.band = @band unless Timeslot.where(band_id: @band.id, event_id: @event.id).exists?
      else
        # if FALSE --> create the band and create the TS with the new band and the venue
        @band = Band.new(name: band.last[:name])
        @band.save
        @ts.band = @band
      end
      @ts.save
    end
  end

  def destroy_timeslot
    # get all the timeslot connected to this event
    @ts = Timeslot.where(event_id: @event.id)
    # loop thru TS
    @ts.each do |ts|
      # get the band name of the ts
      ts_band_name = Band.find(ts.band_id).name
      # get an array of bands name of the bnad inside params
      band_names = event_params[:bands_attributes].to_unsafe_h.to_a.flatten.select { |x| x.is_a?(Hash) }.map { |h| h["name"] }
      # destroy ts if ts_band_name is not include in the params bands names
      ts.destroy unless band_names.include?(ts_band_name)
    end
  end
end
