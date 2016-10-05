class Admin::PlayersController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  load_and_authorize_resource
  require 'nokogiri'
  require 'open-uri'
  require 'webrick/httputils'

  def index
    players_scope = Player.active
    players_scope = players_scope.where("lower(name) ILIKE ?", "%#{params[:name].downcase}%") unless params[:name].blank?
    players_scope = players_scope.where("team_id = ?", params[:team_id]) unless params[:team_id].blank?
    players_scope = players_scope.where("position = ?", params[:position]) unless params[:position].blank?

    smart_listing_create :players, players_scope, partial: "admin/players/listing"
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.create(player_params)
  end

  def edit
  end

  def update
    @player.update_attributes(player_params)
  end

  def destroy
    @player.destroy
  end

  def calculate_prices
    players_url = "http://www.rincondelmanager.com/smgr/stats.php?nombre="
    not_found_players = []

    Player.all.each do |player|
      player_url = WEBrick::HTTPUtils.escape(players_url + player.name)
      if player_html = Nokogiri::HTML(open(player_url))

        price_up_down = player_html.css("table.sm_jug > tr[3] > td[13] > b > text()").first.to_s.gsub(',', '.').to_f
        player.price["1"] = (player.price["2"] + price_up_down * -1.to_f).round(3) if player.price["2"]
        player.save!
      else
        not_found_players << player
      end
    end
    puts "Not Found Players = "+not_found_players.count.to_s
    not_found_players.each do |p|
      puts p.name
    end
    redirect_to admin_players_path and return
  end

  def import
    players_url = Setting.find_by_key("players_url").value
    players_html = Nokogiri::HTML(open(players_url))

    players_html.css("table.listaJugadores > tr").each do |player_row|
      name = player_row.css('td[1]//text()').to_s
      team_name = player_row.css('td[2]/text()').to_s

      unless name.blank?
        unless player = Player.find_by_name(name)
          player = Player.new
        end
        player.name = name
        player.team = Team.where("name = ? OR second_name = ?", team_name, team_name).first

        player.href = Array.wrap(player_row.css("td[1]/a").map { |link| link['href'] })[0].to_s
        player.save!

        import_player player
      end
    end
    redirect_to admin_players_path and return
  end

  def import_player player
    players_url = player.href
    players_url.force_encoding('binary')
    players_url = WEBrick::HTTPUtils.escape(players_url)
    player_html = Nokogiri::HTML(open(players_url))

    player_html.css("td.fichaJugadorData").each do |player_data|
      position_detail = player_data.css('p[2]//text()').to_s
      height = player_data.css('p[3]/strong[1]/text()').to_s
      date_of_birth = player_data.css('p[5]/strong[1]/text()').to_s
      place_of_birth = player_data.css('p[5]/strong[2]/text()').to_s

      player.position_detail = position_detail
      player.height = height
      player.date_of_birth = date_of_birth
      player.place_of_birth = place_of_birth
    end
    player_html.css("td.fichaJugadorimg").each do |player_image|
      #image = Array.wrap(player_image.css("img").map { |link| link['src'] })[0].to_s
      #player.image = image
    end
    player_html.css("table.fichaJugadorSM").each do |player_sm|
      price = player_sm.css('tr[3]/td[2]/text()')
      player.price["#{CURRENT_ROUND}"] = "#{price}".to_f
    end
    player.save!
  end

  private
    def find_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit([:name, :position, :team_id, :href, :active])
    end
end