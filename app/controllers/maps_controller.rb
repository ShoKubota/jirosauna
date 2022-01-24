class MapsController < ApplicationController
  def search
    unless params[:q]
      gon.latitude = 35.64806
      gon.longitude = 139.7416326
    else
      latitude = geo_params[:latitude].to_f
      longitude = geo_params[:longitude].to_f

      @jiros = Jiro.all.within(1, origin: [latitude, longitude])
      @saunas = Sauna.all.within(1, origin: [latitude, longitude])

      gon.latitude = latitude
      gon.longitude = longitude
      gon.jiros = @jiros
      gon.saunas = @saunas
    end
  end

  def result
  end

  private

  def geo_params
    params.require(:q).permit(:latitude, :longitude)
  end

end
