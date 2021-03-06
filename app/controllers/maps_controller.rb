# frozen_string_literal: true

class MapsController < ApplicationController
  def search
    search_radius = 1.5
    default_lat = 35.64806
    default_lng = 139.7416326
    if params[:q]
      @latitude = geo_params[:latitude].to_f
      @longitude = geo_params[:longitude].to_f
      @jiros = Jiro.all.within(search_radius, origin: [@latitude, @longitude]).by_distance(origin: [@latitude, @longitude])
      @saunas = Sauna.all.within(search_radius, origin: [@latitude, @longitude]).by_distance(origin: [@latitude, @longitude])
      @area = search_area(@latitude, @longitude)
      gon.latitude = @latitude
      gon.longitude = @longitude
      gon.jiros = @jiros
      gon.saunas = @saunas
    else
      gon.latitude = default_lat
      gon.longitude = default_lng
    end
  end

  def result; end

  private

  def geo_params
    params.require(:q).permit(:latitude, :longitude)
  end

  def search_area(lat, long)
    geoapi_url = "https://geoapi.heartrails.com/api/json?method=searchByGeoLocation&x=#{long}&y=#{lat}"
    geoapi_page = URI.open(geoapi_url).read
    geoapi_data = JSON.parse(geoapi_page)
    prefecture = geoapi_data['response']['location'][0]['prefecture']
    city = geoapi_data['response']['location'][0]['city']
    town = geoapi_data['response']['location'][0]['town']

    "#{prefecture}#{city}#{town}"
  end
end
