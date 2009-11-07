class PasswordResetsController < ApplicationController

  def new
    permanent_redirect("http://www.folksemantic.com/forgot_password")
  end
  
end