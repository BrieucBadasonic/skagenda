class VenueController < ApplicationController
  def index
    @venues = policy_scope(Venue).order(name: :asc)
  end

  def edit
    @venue = Venue.find(params[:id])
    authorize @venue
  end

  def update
    @venue = Venue.find(params[:id])
    authorize @venue
    @venue.update(venue_params)
    redirect_to venue_index_path
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :address, :website)
  end
end
