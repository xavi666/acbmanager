class Admin::SettingsController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  load_and_authorize_resource

  def index
    settings_scope = Setting.all
    settings_scope = settings_scope.where("lower(name) ILIKE ?", "%#{params[:name].downcase}%") if params[:name]
    settings_scope = settings_scope.where("lower(key) ILIKE ?", "%#{params[:key].downcase}%") if params[:key]
    settings_scope = settings_scope.where("lower(value) ILIKE ?", "%#{params[:value].downcase}%") if params[:value]

    smart_listing_create :settings, settings_scope, partial: "admin/settings/listing"
  end

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.create(setting_params)
  end

  def edit
  end

  def update
    @setting.update_attributes(setting_params)
  end

  def destroy
    @setting.destroy
  end

  private
    def find_setting
      @setting = Setting.find(params[:id])
    end

    def setting_params
      params.require(:setting).permit([:name, :key, :value])
    end
end