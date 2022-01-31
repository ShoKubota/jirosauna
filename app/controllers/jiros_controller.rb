class JirosController < ApplicationController
  def index
    @jiros = Jiro.page(params[:page])
  end

  def show
  end
end
