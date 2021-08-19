class BandsController < ApplicationController
  def index
    @bands = policy_scope(Band).order(name: :asc)
  end

  def edit
    @band = Band.find(params[:id])
    authorize @band
  end

  def update
    @band = Band.find(params[:id])
    authorize @band
    @band.update(band_params)
    redirect_to bands_path
  end

  private

  def band_params
    params.require(:band).permit(:name, :website)
  end
end
