class EventsController < ApplicationController
  # after_action :verify_policy_scoped, except: [:index, :show, :new, :create, :confirmation, :confirmed, :edit, :update], unless: :skip_pundit?
  skip_before_action :authenticate_user!, only: [:index]
  before_action :skip_authorization, only: [:index, :show, :new, :create, :confirmation, :confirmed, :edit, :update]
  before_action :find_event, only: [:edit, :update, :destroy, :confirmed, :update_venue]

  def index
    if params[:query].present?
      @events = Event.global_search(params[:query])
    else
      @events = policy_scope(Event).active.order(date: :asc)
    end
    @events
  end

  def confirmation
    @events = policy_scope(Event).active.order(date: :asc)
    authorize @events
  end

  def confirmed
    @event.confirm = true
    @event.save
    redirect_to events_path, notice: "Event was successfully confirmed"
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
    @event = Event.new(date: event_params[:date], price: event_params[:price],
                      presale: event_params[:presale], organisateur: event_params[:organisateur],
                      link: event_params[:link], photo: event_params[:photo])
    @event.user = current_user
    # calling 2 private method to check venue and band
    # associate an existing venue/band to the event or create a new one
    @event.venue = checking_venue
    checking_band

    @event.save!

    #  authorize the event in pundit, save it and redirect
    # authorize @event
    redirect_to events_path, notice: "Event was successfully created" if @event.save
  end

  def edit
    @venue = @event.venue
    authorize @venue
    @event.bands.build
  end

  def update
    # use my checking venue method
    venue = checking_venue
    @event.update(venue: venue)

    # delete existing event.bands if they are not in the update
    remove_band
    # use my checking band method
    checking_band
    redirect_to events_path, notice: "Event was successfully updated"
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted"
  end

  private

  def event_params
    params.require(:event).permit(:date, :price, :presale, :organisateur, :link, :photo, :venue_id, band_ids: [], venue: [:name, :address, :website], bands_attributes: [:id, :name, :website])
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
      venue_id = event_params[:venue_id].to_i
      venue = Venue.find(venue_id)
    end
  end

  def checking_band
    # band stuff
    # selected bands
    event_params[:band_ids].reject(&:empty?).each do |band_id|
      band = Band.find(band_id.to_i)
      @event.bands << band unless @event.bands.include?(band)
    end
    # non existing bands
    event_params[:bands_attributes].to_unsafe_h.each do |key|
      if key[1][:name] != "" && key[1][:id].nil?
        band = Band.new(name: key[1][:name], website: key[1][:website])
        @event.bands << band if band
      end
    end
  end
  def remove_band
    # make an array with all the band id of all the event.timeslots
    timeslot_band_ids = @event.timeslots.map(&:band_id)

    # make an array with all the band id coming from the form "band_ids"
    form_band_ids = event_params[:band_ids].filter { |band_id| band_id != "" }.map(&:to_i)

    # adding the band_id coming from bands_attributes if they exist
    event_params[:bands_attributes].to_unsafe_h.each { |key| form_band_ids << key[1][:id].to_i if key[1].key?("id") && key[1][:name] != "" }
    form_band_ids.uniq!

    # destroy the timeslot if we don't need for the update
    timeslot_band_ids.each do |timeslot_band_id|
      @event.timeslots.where(band_id: timeslot_band_id).first.destroy unless form_band_ids.include?(timeslot_band_id)
    end
  end
end
