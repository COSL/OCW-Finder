class ApplicationController < ActionController::Base
  
  layout 'default'
    
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
    
  protected
  
  def permanent_redirect(url)
    headers["Status"] = "301 Moved Permanently"
    redirect_to url
  end
  
  def current_user
    nil
  end
  
  def setup_paging
    @page = (params[:page] || 1).to_i
    @page = 1 if @page < 1
    @per_page = (params[:per_page] || (Rails.env=='test' ? 1 : 40)).to_i
  end
  
  def ssl_required?
    false
  end
  
end
