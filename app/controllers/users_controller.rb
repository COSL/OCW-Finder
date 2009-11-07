class UsersController < ApplicationController

  def new
    permanent_redirect("http://www.folksemantic.com/signup")
  end
  
end