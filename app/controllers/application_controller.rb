class ApplicationController < ActionController::Base
 # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  # By default, throw an exception if we're not running cancancan against the controller
  #check_authorization :unless => :devise_controller?

  # By default, assume no-one can see anything
  before_filter :authenticate_user!, :check_active_account, :set_current_user, :dirty_response_headers, :set_locale

  # Throw away flash messages after AJAX request
  # (stops alerts etc popping up on next page load)
  after_filter { flash.discard if request.xhr? }

  layout :set_layout
  def set_layout
    if current_user and current_user.super_admin
      'back'
    end
  end

  def check_active_account
    if current_user and ! current_user.active
      sign_out current_user
      redirect_to :root
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end

  def page
    params[:page]
  end

  def set_current_user
    User.current = current_user
  end

  def dirty_response_headers
    case request.format
    when "Mime::PDF"
      response.headers['Content-Type'] = 'application/pdf'
      response.headers['Content-Disposition'] = 'attachment; filename=temp.pdf'
    when "Mime::CSV"
      response.headers['Content-Type'] = 'text/csv'
      response.headers['Content-Disposition'] = 'attachment; filename=temp.csv'
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end