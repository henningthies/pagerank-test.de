class DomainsController < ApplicationController
  
  before_filter :get_last_searches
  
  def search
    if params[:domain]
      @domain = Domain.find_by_url(tune_url(params[:domain][:url]))
      @domain ||= Domain.create(params[:domain])
      if @domain.pageranks.blank? || @domain.pageranks.last.rank.nil?
        @domain.destroy
        @domain = nil
      end
    end
    
    respond_to do |wants|
      wants.html {
        if @domain
          redirect_to "/#{@domain.url}" 
        else
          flash[:error] = "Domain nicht gefunden" if params[:domain] && @domain.nil?
          url = params[:domain][:url] if params[:domain]
          url ||= "deine-domain.de"
          @domain = Domain.new :url => url
        end
      }
      wants.js{
        render :inline => "error"
      }
    end
  end
  
  
  def detail
    @domain = Domain.find_by_url!(params[:url])
    @domain.touch
    pageranks = @domain.pageranks
    
    respond_to do |wants|
      wants.html { render :action => "detail" }
    end
  end
  
  def impressum
    @domain = Domain.new :url => "deine-domain.de"
  end
  
  private 
  def get_last_searches
    @last_domains = Domain.find(:all, :limit => 15, :order => "updated_at desc")
    #@random_domains = Domain.find(:all, :limit => 15, :order => "rand()")
  end
  
  def tune_url(url)
    s = url
    s.downcase!
    s.gsub!("http://","")
    s.gsub!("https://","")
    s.gsub!("www.","")
    s.gsub!(" ","")
    s = s.split("/").first
    s
  end
  
end
