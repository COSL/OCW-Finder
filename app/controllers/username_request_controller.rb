class UsernameRequestController < ApplicationController

  def new
    permanent_redirect("http://www.folksemantic.com/forgot_username")
  end

end