class Admin::StatisticsController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  load_and_authorize_resource
  require 'nokogiri'

  def index
    statistics_scope = Statistic.all

    smart_listing_create :statistics, statistics_scope, partial: "admin/statistics/listing"
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
    players_url = Setting.find_by_key("statistics_url").value
    players_html = Nokogiri::HTML(open(players_url))

    players_html.css("table.listaJugadores > tr").each do |player_row|
      name = player_row.css('td[1]//text()').to_s
      team_name = player_row.css('td[2]/text()').to_s

      unless name.blank?
        if player = Player.find_by_name(name)

          player.href = Array.wrap(player_row.css("td[1]/a").map { |link| link['href'] })[0].to_s
          import_statistic player
        end
      end
    end
    redirect_to admin_statistics_path and return
  end

  def import_statistic player
    players_url = player.href
    players_url.force_encoding('binary')
    players_url = WEBrick::HTTPUtils.escape(players_url)
    player_html = Nokogiri::HTML(open(players_url))

    current_season = CURRENT_SEASON

    unless statistic = Statistic.where(season: current_season).where(player_id: player.id).first
      statistic = Statistic.new
      statistic.season = current_season
      statistic.player_id = player.id
      statistic.save!
    end

    player_html.css("table.fichaJugadorStats > tr").each do |row_statistic|
      partido = row_statistic.css("th[1]/text()").to_s.downcase
      if partido == 'promedio' || partido == 'total' || partido == '1'
        partido = "week_1" if partido == '1'
        game = row_statistic.css("td[2]/text()")
        minutos = row_statistic.css("td[3]/text()")
        puntos = row_statistic.css("td[4]/text()")
        t2 = row_statistic.css("td[5]/text()")
        t3 = row_statistic.css("td[7]/text()")
        t1 = row_statistic.css("td[9]/text()")
        reb = row_statistic.css("td[11]/text()")
        a = row_statistic.css("td[12]/text()")
        br = row_statistic.css("td[13]/text()")
        bp = row_statistic.css("td[14]/text()")
        c = row_statistic.css("td[15]/text()")
        tap = row_statistic.css("td[16]/text()")
        m = row_statistic.css("td[17]/text()")
        fp = row_statistic.css("td[18]/text()")
        fr = row_statistic.css("td[19]/text()")
        mas_menos = row_statistic.css("td[20]/text()")
        v = row_statistic.css("td[21]/text()")
        sm = row_statistic.css("td[22]/text()")

        values = {
          game: game.to_s,
          min: minutos.to_s,      pt: puntos.to_s,          t2: t2.to_s, 
          t3: t3.to_s,            t1: t1.to_s,              reb: reb.to_s,
          a: a.to_s,              br: br.to_s,              bp: bp.to_s,                
          c: c.to_s,              tap: tap.to_s,            m: m.to_s,
          fp: fp.to_s,            fr: fr.to_s,              mas_menos: mas_menos.to_s,
          v: v.to_s,              sm: sm.to_s
        }
        statistic.send("#{partido}=", values)
        statistic.save!
      end
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