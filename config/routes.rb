ActionController::Routing::Routes.draw do |map|
  
  map.connect 'resources/tags/*tags', :controller => 'entries', :action => 'browse_by_tags'
  map.search_resources 'resources/search', :controller => 'entries', :action => 'search'
  
  map.connect '/', :controller => 'entries'
  map.home '', :controller => 'entries'
  map.root :controller => 'entries'
  
  map.resources :entries
  map.resources :comments

  # top level pages
  map.contact '/contact', :controller => 'default', :action => 'contact'
  map.sitemap '/about', :controller => 'default', :action => 'about'
  map.ping '/ping', :controller => 'default', :action => 'ping'
  
end
