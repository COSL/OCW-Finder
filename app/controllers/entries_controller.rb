class EntriesController < Muck::EntriesController

  caches_page :courses

  def index
    return courses_for_feed if params[:feed_id]
    respond_to do |format|
      format.html {render :layout => "default"}
      format.rss do
        @entries = Entry.find(:all, :include => :tags)
        render :layout => false
      end
    end
  end

  def part
    @languages = Feed.used_languages
    @code = params[:language] || "en"

    respond_to do |format|
      format.html {render :layout => false}
    end
  end

  def courses_for_feed
    @new_feed = params[:new_feed]
    feed_id = params[:feed_id]
    if !logged_in? and params[:key] == ADMIN_ACCESS_KEY
      redirect_to :controller => "feeds", :action => "login", "redirect" => feed_id + "/entries"
      return
    end 
    @feed = Feed.find(feed_id)
    @courses = @feed.entries.find(:all, :order => "title")
    respond_to do |format|
      format.html {render :partial => "feed_courses", :layout => "default"}
    end
  end

  def courses
    @tags = params[:tags]
    @courses = Entry.find_tagged_with(:all => @tags, :order => "title")

    respond_to do |format|
      format.html { render :partial => "courses", :layout => false }
      format.xml  { render :xml => @courses.to_xml }
    end
  end

  def search
    @terms = params[:terms]
    @language = params[:language]
    if !@terms.nil? && @terms.length > 0
      @courses = Entry.search(@terms, @language, :order => "title")
    else
      @courses = []
    end

    respond_to do |format|
      format.html { render :partial => "courses", :layout => false }
      format.xml  { render :xml => @courses.to_xml }
    end
  end

  def show
    @entry = Entry.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @entry.to_xml }
    end
  end

end
