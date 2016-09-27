# == Schema Information
#
# Table name: games
#
#

class Game < ActiveRecord::Base
  # !**************************************************
  # !                Associations
  # !**************************************************
  belongs_to :local_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"

  # !**************************************************
  # !                Validations
  # !**************************************************

  # !**************************************************
  # !                Callbacks
  # !**************************************************

  # !**************************************************
  # !                  Other
  # !**************************************************  
  scope :by_season, -> (season) { where(:season => season) }
  scope :by_round,  -> (round)  { where(:round  => round) }

  def to_s
    name
  end

  def self.active
    where(active: true)
  end
end