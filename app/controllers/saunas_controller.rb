class SaunasController < ApplicationController
  def index
    @q = Sauna.ransack(params[:q])
    @saunas = @q.result.page(params[:page])
  end

  def show
    search_radius = 1.5
    @sauna = Sauna.find_by(id: params[:id])
    @longitude = @sauna.longitude
    @latitude = @sauna.latitude
    @jiros = Jiro.all.within(search_radius, origin: [@latitude, @longitude]).by_distance(origin: [@latitude, @longitude])
  end
end
