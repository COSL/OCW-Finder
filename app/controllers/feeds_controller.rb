class FeedsController < Muck::FeedsController
  
  def index
    permanent_redirect("http://www.folksemantic.com")
  end
  
  def new
    permanent_redirect("http://www.folksemantic.com/feeds/new")
  end

end