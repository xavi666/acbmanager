# == Schema Information
#
# Table name: players
#
#

class Player < ActiveRecord::Base
  # !**************************************************
  # !                Associations
  # !**************************************************
  #has_many :statistics, dependent: :destroy
  belongs_to :team
  #belongs_to :user_team_players
  #has_many :predictions, dependent: :destroy
  #has_many :prices, dependent: :destroy

  # !**************************************************
  # !                Validations
  # !**************************************************

  # !**************************************************
  # !                Callbacks
  # !**************************************************
  before_update :set_position

  # !**************************************************
  # !                  Other
  # !**************************************************
  include PlayerAllowed
  extend Enumerize
  enumerize :position, in: ["base", "alero", "pivot"], predicates: true
  
  monetize :price_cents, allow_nil: true

  def to_s
    name
  end

  def print_price
    ActiveSupport::NumberHelper.number_to_delimited(price.to_i, :delimiter => ".")
  end

  def set_position
    unless position_detail.nil?
      self.position_detail = position_detail.parameterize.underscore
      self.position = position_detail
      self.position = "pivot" if self.position_detail == "Alapívot".parameterize.underscore
      self.position = "alero" if self.position_detail == "Escolta".parameterize.underscore
    end
  end

end