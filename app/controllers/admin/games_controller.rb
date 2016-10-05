class Admin::GamesController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  load_and_authorize_resource
  require 'nokogiri'
  require 'open-uri'
  require 'webrick/httputils'
  require 'date'

  def index
    games_scope = Game.active.order(:game_date)
    games_scope = games_scope.where("local_team_id = ?", params[:local_team_id]) unless params[:local_team_id].blank?
    games_scope = games_scope.where("away_team_id = ?", params[:away_team_id]) unless params[:away_team_id].blank?

    smart_listing_create :games, games_scope, partial: "admin/games/listing"
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
  end

  def edit
  end

  def update
    @game.update_attributes(game_params)
  end

  def destroy
    @game.destroy
  end

  def import
    games_url = Setting.find_by_key("games_url").value
    games_html = Nokogiri::HTML(open(games_url))
    num_game = 0
    current_season = CURRENT_SEASON

    games_html.css("table.menuclubs > tr").first(2).each do |game_row|
      teams = game_row.css('td[2]//text()').to_s
      date_score = game_row.css('td[3]//text()').to_s
      array_teams = teams.split(" - ")
      local = Team.find_by_name(array_teams[0])
      away = Team.find_by_name(array_teams[1])

      if local and away 
        game = Game.where(local_team_id: local.id).where(away_team_id: away.id).first
        unless game
          game = Game.new
          game.local_team_id = local.id
          game.away_team_id = away.id
        end

        # Sate - Result
        if date_score.include? ' - '
          array_score = date_score.split(" - ")
          game.local_score = array_score[0]
          game.away_score = array_score[1]
        else
          game.game_date = !date_score.blank? ? DateTime.parse(date_score) : ""
        end

        game.season = current_season
        game.round = (num_game / 8) + 1
        game.save!
      end
      num_game += 1
    end
    redirect_to admin_games_path and return
  end

  def import_game game
    games_url = game.href
    games_url.force_encoding('binary')
    games_url = WEBrick::HTTPUtils.escape(games_url)
    game_html = Nokogiri::HTML(open(games_url))

    game_html.css("td.fichaJugadorData").each do |game_data|
      position_detail = game_data.css('p[2]//text()').to_s
      height = game_data.css('p[3]/strong[1]/text()').to_s
      date_of_birth = game_data.css('p[5]/strong[1]/text()').to_s
      place_of_birth = game_data.css('p[5]/strong[2]/text()').to_s
      

      game.position_detail = position_detail
      game.height = height
      game.date_of_birth = date_of_birth
      game.place_of_birth = place_of_birth
    end
    game_html.css("td.fichaJugadorimg").each do |game_image|
      image = Array.wrap(game_image.css("img").map { |link| link['src'] })[0].to_s
      game.image = image
    end
    game.save!
  end

  private
    def find_game
      @game = Player.find(params[:id])
    end

    def game_params
      params.require(:game).permit([:season, :round, :local_team_id, :away_team_id, :game_date])
    end
end