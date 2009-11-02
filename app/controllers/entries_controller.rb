class EntriesController < Muck::EntriesController
  before_filter :setup_grain_size
  
  def setup_grain_size
    @grain_size = 'course'
    @main_domain = 'http://www.folksemantic.com'
  end

  def browse_by_tags
    @tag_filter = params[:tags]
    @level = params[:level]
    if !fragment_exist?({:controller => 'entries', :action => 'browse_by_tags', :language => Language.locale_id, :filter => @tag_filter, :grain_size => @grain_size})
      @tag_cloud = TagCloud.language_tags(Language.locale_id, @grain_size, @tag_filter)
    end
    respond_to do |format|
      format.html { render :template => 'entries/browse_by_tags', :layout => false }
    end
  end

  def search
    @search = params[:q]
    _search
    respond_to do |format|
      format.html { render :template => 'entries/search', :layout => false }
    end
  end

end
