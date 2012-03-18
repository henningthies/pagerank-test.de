class SitemapController < ApplicationController
  
  caches_page :index
  
  def index
    @domains = Domain.order("updated_at DESC")
    render(:template => "sitemap/index", :formats => [:xml], :handlers => :builder, :layout => false)
  end
end
