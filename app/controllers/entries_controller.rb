class EntriesController < Muck::EntriesController
  before_filter :setup_grain_size
  
  caches_page [:index]
  
  def setup_grain_size
    @grain_size = 'course'
    @main_domain = 'http://www.folksemantic.com'
  end

  def index
    @tag_cloud = TagCloud.language_tags(Language.locale_id, @grain_size) unless fragment_exist?({:controller => 'entries', :action => 'index', :language => Language.locale_id})
    respond_to do |format|
      format.html { render :template => 'entries/index' }
    end
  end

  def list_tags
    @tag_filter = params[:tags]
    @level = params[:level]
    if !fragment_exist?({:controller => 'entries', :action => 'list_tags', :language => Language.locale_id, :filter => @tag_filter, :grain_size => @grain_size})
      @tag_cloud = TagCloud.language_tags(Language.locale_id, @grain_size, @tag_filter)
    end
    respond_to do |format|
      format.html { render :template => 'entries/browse_by_tags', :layout => false }
    end
  end

  def browse_courses
    @tag_filter = params[:tags]
    @search = 'tags:"' + @tag_filter.join('" tags:"') + '"'
    @search_type = 'browse'
    _search(:and)
    respond_to do |format|
      format.html { render :template => 'entries/search', :layout => false }
    end
  end

  def search
    @search = params[:q]
    @search_type = 'search'
    _search
    respond_to do |format|
      format.html { render :template => 'entries/search', :layout => false }
    end
  end

  def _search operator = :or
    @page = (params[:page] || 1).to_i
    @per_page = (params[:per_page] || 10).to_i
    @offset = (@page-1)*@per_page
    if !@search.nil?
      @term_list = URI.escape(@search)
      results = Entry.search(@search, @grain_size, I18n.locale.to_s, @per_page, @offset, operator)
      @hit_count = results.total
      @results = results.results
      @paginated_results = @results.paginate(:page => @page, :per_page => @per_page, :total_entries => @hit_count)
      log_query(current_user.nil? ? request.remote_addr : current_user.id, Language.locale_id, @tag_filter.nil? ? 'search' : 'browse', @search, @grain_size, @hit_count)
    end
  rescue RuntimeError, MuckServices::Exceptions::LanguageNotSupported => ex
    @hit_count = 0
    @results = []
    flash[:error] = t('muck.services.search_problem') + '<p class="support-information">Information for support: <br />' + ex.to_s + '</p>'
  end

end
