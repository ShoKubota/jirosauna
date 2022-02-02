class JirosController < ApplicationController
  def index
    @q = Jiro.ransack(params[:q])
    @jiros = @q.result.page(params[:page])
  end

  def show
    @jiro = Jiro.find_by(id: params[:id])
    @saunas = Sauna.all.within(1.5, origin: [@jiro.latitude, @jiro.longitude]).by_distance(origin: [@jiro.latitude, @jiro.longitude])
  end
end
