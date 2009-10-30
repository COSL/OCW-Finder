class ApplicationController < ActionController::Base
  
  acts_as_muck_content_handler
  
  include SslRequirement
  layout 'default'
    
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
    
  protected
  
  # called by Admin::Muck::BaseController to check whether or not the
  # user should have access to the admin UI
  def admin_access?
    access_denied unless admin?
  end
  
  # only require ssl if we are in production
  def ssl_required?
    return ENV['SSL'] == 'on' ? true : false if defined? ENV['SSL']
    return false if local_request?
    return false if RAILS_ENV == 'test'
    ((self.class.read_inheritable_attribute(:ssl_required_actions) || []).include?(action_name.to_sym)) && (RAILS_ENV == 'production' || RAILS_ENV == 'staging')
  end
  
  def setup_paging
    @page = (params[:page] || 1).to_i
    @page = 1 if @page < 1
    @per_page = (params[:per_page] || (Rails.env=='test' ? 1 : 40)).to_i
  end
  
end
