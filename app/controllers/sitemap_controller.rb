class SitemapController < ApplicationController
  def index
    @domains = Domain.find(:all, :order => 'updated_at DESC')
    respond_to do |wants|
      wants.xml {  }
    end
  end
end
