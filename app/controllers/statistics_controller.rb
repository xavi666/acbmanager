class StatisticsController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  load_and_authorize_resource

  def index
    statistics_scope = Statistic.all

    smart_listing_create :statistics, statistics_scope, partial: "statistics/listing"
  end

  private

    def statistic_params
      params.require(:statistic).permit([:season])
    end
end