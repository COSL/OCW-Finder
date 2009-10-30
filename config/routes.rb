ActionController::Routing::Routes.draw do |map|
  
  map.connect '/tags/:language', :controller => 'tags', :action => 'index'
  
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
