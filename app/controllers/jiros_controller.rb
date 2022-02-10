class JirosController < ApplicationController
  def index
    @q = Jiro.ransack(params[:q])
    @jiros = @q.result.page(params[:page])
  end

  def show
    @jiro = Jiro.find_by(id: params[:id])
    @longitude = @jiro.longitude
    @latitude = @jiro.latitude
    @saunas = Sauna.all.within(1.5, origin: [@latitude, @longitude]).by_distance(origin: [@latitude, @longitude])
  end
end
