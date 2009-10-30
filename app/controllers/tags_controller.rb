class TagsController < ApplicationController

  layout false

  caches_page :index, :overlapping_tags

  def index
    @grain_size = params[:grain_size] || 'all'
    @tag_cloud = TagCloud.language_tags(Language.locale_id, @grain_size) unless fragment_exist?({:controller => 'entries', :action => 'index', :language => Language.locale_id})
    respond_to do |format|
      format.html { render :partial => "tag_link", :layout => false, :collection => @tags, :locals => {:level => 2, :tags => ""}}# index.rhtml
      format.xml  { render :xml => @tags.to_xml }
    end
  end

  def overlapping_tags
    select_tags = params[:tags]
    @tags = Tag.related_tags(params[:language], select_tags)
    level = params[:level].to_i
    respond_to do |format|
      format.html { render :partial => "tag_link", :collection => @tags, :locals => {:level => level + 1, :tags => select_tags.to_s.gsub('/',' ') + " "}}# index.rhtml
      format.xml  { render :xml => @tags.to_xml }
    end
  end

end
