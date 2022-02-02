class JirosController < ApplicationController
  def index
    @q = Jiro.ransack(params[:q])
    @jiros = @q.result.page(params[:page])
  end

  def show
  end
end
