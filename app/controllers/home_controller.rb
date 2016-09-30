class HomeController < ApplicationController

  def index
    @games = Game.by_season(CURRENT_SEASON).by_round(CURRENT_ROUND)
  end

  private
    def home_params
    end

end