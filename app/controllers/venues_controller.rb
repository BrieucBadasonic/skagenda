class VenuesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    name = params[:venue][:name]

    if Venue.exists?(name: name)
      # if the venue exist in the db, get it
      @venue = Venue.where(name: name)[0]
    else
      # if not, create a new venue with the params
      @venue = Venue.new(venue_params)
      @venue.save
    end
    authorize @venue
    authorize @event
    @event.update(venue: @venue)
    render json: { html: render_to_string(partial: 'edit-venue'),
                   venue: { name: @venue.name.to_s,
                            address: @venue.address.to_s } }
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :address)
  end
end
