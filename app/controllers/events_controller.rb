class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :skip_authorization, only: :index
  before_action :find_event, only: [:edit, :update, :destroy, :confirmed]
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
    @event.venue = @venue
    @event.bands.build
  end

  def create
    @event = Event.new(event_params)
    authorize @event
    user = current_user
    venue = Venue.last
    @event.user = user
    @event.venue = venue
    if @event.save
      render json: { html: render_to_string(partial: 'edit-event'),
                     event: Event.last.id }
    end
  end

  def edit
    @venue = @event.venue
    authorize @venue
    # @event.bands.build
  end

  def update
    date = Date.parse params[:event][:date]
    price = params[:event][:price]

    unless @event.date == date && @event.price == price.to_i
      @event.update(date: date, price: price)
    end
    render json: { html: render_to_string(partial: 'edit-event'),
                   event: @event.id }
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted"
  end

  private

  def event_params
    params.require(:event).permit(:date, :price, :photo)
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
end
