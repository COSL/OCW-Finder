class UserSessionsController < ApplicationController
  
  def new
    permanent_redirect("http://www.folksemantic.com/login")
  end
  
  def show
    permanent_redirect("http://www.folksemantic.com/login")
  end
  
end