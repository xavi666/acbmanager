class StatisticsController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  load_and_authorize_resource
  require 'nokogiri'

  def index
    statistics_scope = Statistic.all

    smart_listing_create :statistics, statistics_scope, partial: "statistics/listing"
  end

  def new
    @statistic = Statistic.new
  end

  def create
    @statistic = Statistic.create(statistic_params)
  end

  def edit
  end

  def update
    @statistic.update_attributes(statistic_params)
  end

  def destroy
    @statistic.destroy
  end

  def import
    players_url = "http://kiaenzona.com/jugadores-liga-endesa"
    players_html = Nokogiri::HTML(open(players_url))

    players_html.css("table.listaJugadores > tr").first(2).each do |player_row|
      name = player_row.css('td[1]//text()').to_s
      team_name = player_row.css('td[2]/text()').to_s

      unless name.blank?
        if player = Player.find_by_name(name)

          player.href = Array.wrap(player_row.css("td[1]/a").map { |link| link['href'] })[0].to_s
          import_statistic player
        end
      end
    end
    redirect_to statistics_path and return
  end

  def import_statistic player
    players_url = player.href
    players_url.force_encoding('binary')
    players_url = WEBrick::HTTPUtils.escape(players_url)
    player_html = Nokogiri::HTML(open(players_url))

    player_html.css("table.fichaJugadorStats > tr").each do |row_statistic|
      puts "-------> STATISTIC"
      puts row_statistic
      partido = row_statistic.css("th[1]/text()")
      puts partido
      puts '-----'
      puts '-----'
    end
  end

  private
    def find_statistic
      @statistic = Statistic.find(params[:id])
    end

    def statistic_params
      params.require(:statistic).permit([:season])
    end
end