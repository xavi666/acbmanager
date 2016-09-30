class Admin::TeamsController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  load_and_authorize_resource

  def index
    teams_scope = Team.active
    teams_scope = teams_scope.where("lower(name) ILIKE ?", "%#{params[:name].downcase}%") if params[:name]

    smart_listing_create :teams, teams_scope, partial: "admin/teams/listing"
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
  end

  def edit
  end

  def update
    @team.update_attributes(team_params)
  end

  def destroy
    @team.destroy
  end

  private
    def find_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit([:name, :second_name, :short_code, :active])
    end
end