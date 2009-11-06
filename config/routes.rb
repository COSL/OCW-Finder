ActionController::Routing::Routes.draw do |map|
  
  map.connect 'resources/tags/*tags', :controller => 'entries', :action => 'list_tags'
  map.connect 'resources/browse/*tags', :controller => 'entries', :action => 'browse_courses'
  map.search_resources 'resources/search', :controller => 'entries', :action => 'search'
  
  map.connect '/', :controller => 'entries'
  map.home '', :controller => 'entries'
  map.root :controller => 'entries'
  
  map.resources :entries
  map.resources :comments
  map.resources :feeds
  
  map.resource :user_session
  map.with_options(:controller => 'user_sessions') do |user_sessions|
    user_sessions.login "/login", :action => 'new'
    user_sessions.logout "/logout", :action => 'destroy'
  end
  
  # top level pages
  map.contact '/contact', :controller => 'default', :action => 'contact'
  map.sitemap '/about', :controller => 'default', :action => 'about'
  map.ping '/ping', :controller => 'default', :action => 'ping'
  
end
