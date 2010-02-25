class ApplicationController < ActionController::Base
  
  layout 'default'
    
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  before_filter :set_locale
  before_filter :setup_paging
  before_filter :set_will_paginate_string
  
  protected
  
    def set_locale
      discover_locale
    end
    
    def permanent_redirect(url)
      headers["Status"] = "301 Moved Permanently"
      redirect_to url
    end
  
    def current_user
      nil
    end
  
    def ssl_required?
      false
    end
  
end
