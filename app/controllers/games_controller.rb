class GamesController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  load_and_authorize_resource
  require 'nokogiri'
  require 'open-uri'
  require 'webrick/httputils'

  def index
    games_scope = Game.active
    games_scope = games_scope.where("local_team_id = ?", params[:local_team_id]) unless params[:local_team_id].blank?
    games_scope = games_scope.where("away_team_id = ?", params[:away_team_id]) unless params[:away_team_id].blank?

    smart_listing_create :games, games_scope, partial: "games/listing"
  end

  def new
    @game = Player.new
  end

  def create
    @game = Player.create(game_params)
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
    games_url = "http://acb.com/calendario.php?cod_competicion=LACB&cod_edicion=61&vd=1&vh=34"
    games_html = Nokogiri::HTML(open(games_url))

    games_html.css("table.menuclubs").first(2).each do |game_row|
      #name = game_row.css('td[1]//text()').to_s
      #team_name = game_row.css('td[2]/text()').to_s

      #unless name.blank?
      #  unless game = Player.find_by_name(name)
      #    game = Player.new
      #  end
      #  game.name = name
      #  game.team = Team.find_by_name(team_name)

      #  game.href = Array.wrap(game_row.css("td[1]/a").map { |link| link['href'] })[0].to_s
      #  game.save!

      #  import_game game
      #end
    end
    redirect_to games_path and return
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
      params.require(:game).permit([:name, :short_code, :active])
    end
end