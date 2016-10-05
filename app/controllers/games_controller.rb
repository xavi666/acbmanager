class GamesController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    games_scope = Game.active
    games_scope = games_scope.where("local_team_id = ?", params[:local_team_id]) unless params[:local_team_id].blank?
    games_scope = games_scope.where("away_team_id = ?", params[:away_team_id]) unless params[:away_team_id].blank?

    smart_listing_create :games, games_scope, partial: "games/listing"
  end

  def show
    @game = Game.find params[:id]
  end

  def round
    @round = params[:round_id].to_i
    @round_games = Game.by_season(CURRENT_SEASON).by_round(params[:round_id]) if @round
  end

  private
    def find_game
      @game = Player.find(params[:id])
    end

    def game_params
      params.require(:game).permit([:name, :short_code, :active])
    end
end