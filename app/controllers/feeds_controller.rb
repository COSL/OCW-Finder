class FeedsController < ApplicationController
  
  def index
    permanent_redirect("http://www.folksemantic.com")
  end
  
  def show
    permanent_redirect("http://www.folksemantic.com")
  end
  
  def new
    permanent_redirect("http://www.folksemantic.com/feeds/new_oai_rss")
  end

  def edit
    permanent_redirect("http://www.folksemantic.com/feeds/new_oai_rss")
  end
  
end