class JirosController < ApplicationController
  def index
    @jiros = Jiro.all
  end

  def show
  end
end
