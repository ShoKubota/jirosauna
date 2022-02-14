class SaunasController < ApplicationController
  def index
    @q = Sauna.ransack(params[:q])
    @saunas = @q.result.page(params[:page])
  end

  def show
    @sauna = Sauna.find_by(id: params[:id])
    @longitude = @sauna.longitude
    @latitude = @sauna.latitude
    @jiros = Jiro.all.within(1.5, origin: [@latitude, @longitude]).by_distance(origin: [@latitude, @longitude])
  end
end
