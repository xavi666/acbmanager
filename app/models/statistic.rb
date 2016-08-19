# == Schema Information
#
# Table name: statistics
#
#

class Statistic < ActiveRecord::Base
  
  FIELDS = %w( min pt t2 t3 t1 reb a br bp c tap m fp fr mas_menos v små )  
  NUM_GAMES = 34

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
  before_save :set_defaults

  # !**************************************************
  # !                  Other
  # !**************************************************  

  def to_s
    season + " - " + player.to_s
  end

  def self.num_games
    NUM_GAMES
  end

  def self.fields
    FIELDS
  end

  private
    def set_defaults
      values = FIELDS.collect{|field| { field.to_sym => 0 } }
      (1..NUM_GAMES).each do |week|
        self.send("week_#{week}=", values)
      end
    end
end