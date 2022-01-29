# frozen_string_literal: true

class MapsController < ApplicationController
  def search
    if params[:q]
      @latitude = geo_params[:latitude].to_f
      @longitude = geo_params[:longitude].to_f

      @jiros = Jiro.all.within(1.5, origin: [@latitude, @longitude]).by_distance(origin: [@latitude, @longitude])
      @saunas = Sauna.all.within(1.5, origin: [@latitude, @longitude]).by_distance(origin: [@latitude, @longitude])

      gon.latitude = @latitude
      gon.longitude = @longitude
      gon.jiros = @jiros
      gon.saunas = @saunas
    else
      gon.latitude = 35.64806
      gon.longitude = 139.7416326
    end
  end

  def result; end

  private

  def geo_params
    params.require(:q).permit(:latitude, :longitude)
  end
end
