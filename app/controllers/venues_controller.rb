class VenuesController < ApplicationController
  def update
    name = params[:venue][:name]
    address = params[:venue][:address]
    @venue = Venue.find(params[:id])
    unless @venue.name == name && @venue.address == address
      @venue.update(name: name, address: address)
      render json: { html: render_to_string(partial: 'edit-venue') }
    end
      authorize @venue
  end
end
