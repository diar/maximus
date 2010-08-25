# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem

  def admin_authorize
		if !logged_in?
      redirect_to(:controller => 'sessions', :action => 'new')
    end
	end

  def init_page
    @config = {}
    Setting.all.each { |setting| @config[setting.name]=setting.value }
    @menu = Page.find_all_by_level(1)
    if params[:controller] == 'pages'
      @current_page = Page.find_by_uri(params[:id])
    else
      @current_page = Page.find_by_uri(params[:controller])
    end
    if @current_page.nil?
      render :text => 'Страница не найдена', :status=>404
    else
      @current_page = Page.get_first_child(@current_page)
    end
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end