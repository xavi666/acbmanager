# == Schema Information
#
# Table name: statistics
#
#

class Statistic < ActiveRecord::Base
  
  FIELDS = %w( game min pt t2 t3 t1 reb a br bp c tap m fp fr mas_menos v sm )  
  FIELDS_DEFAULT = ["-", "0'", "0", "0/0", "0/0", "0/0", "0(0+0)", "0", "0", "0", "0", "0+0", "0", "0", "0", "0", "0", "0.00" ]  

  NUM_GAMES = Setting.find_by_key("session_rounds").value.to_i

  # !**************************************************
  # !                Associations
  # !**************************************************
  belongs_to :player

  # !**************************************************
  # !                Validations
  # !**************************************************

  # !**************************************************
  # !                Callbacks
  # !**************************************************
  #before_save :set_defaults

  # !**************************************************
  # !                  Other
  # !**************************************************  
  scope :by_season, -> (season) { where(:season => season) }
  scope :by_round,  -> (round)  { where(:round  => round) }
  
  def to_s
    season + " - " + player.to_s
  end

  def self.num_games
    NUM_GAMES.to_i
  end

  def self.fields
    FIELDS
  end

  private
    def set_defaults
      values = {}
      FIELDS.zip(FIELDS_DEFAULT).each do |field, default|
        values[field] = default
      end
      (1..NUM_GAMES).each do |week|
        self.send("week_#{week}=", values)
      end
    end
end