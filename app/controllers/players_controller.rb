class PlayersController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  load_and_authorize_resource

  def index
    players_scope = Player.active
    players_scope = players_scope.where("lower(name) ILIKE ?", "%#{params[:name].downcase}%") unless params[:name].blank?
    players_scope = players_scope.where("team_id = ?", params[:team_id]) unless params[:team_id].blank?
    players_scope = players_scope.where("position = ?", params[:position]) unless params[:position].blank?

    smart_listing_create :players, players_scope, partial: "players/listing"
  end

  private
    def find_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit([:name, :position, :team_id, :href, :active])
    end
end