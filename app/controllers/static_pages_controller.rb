# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def top
    @jiro = Jiro.first
    @jiros = Jiro.all
    @saunas = Sauna.all
  end
end
