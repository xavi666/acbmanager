# == Schema Information
#
# Table name: players
#
#

class Player < ActiveRecord::Base
  # !**************************************************
  # !                Associations
  # !**************************************************
  belongs_to :team
  has_many :statistics

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

  def to_param
    [id.to_s, name.parameterize].join("-")
  end

end