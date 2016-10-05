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
  default_scope { order(round: :asc).order(game_date: :asc) }
  scope :by_season, -> (season) { where(:season => season) }
  scope :by_round,  -> (round)  { where(:round  => round) }

  def to_s
    name
  end

  def self.active
    where(active: true)
  end

  def to_param
    [id.to_s, local_team.name.parameterize, away_team.name.parameterize].join("-")
  end
end