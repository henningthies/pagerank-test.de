require "googlepagerank"
class Pagerank < ActiveRecord::Base
  belongs_to :domain, :class_name => "Domain", :foreign_key => "domain_id"
  before_validation_on_create :check_rank
  validates_presence_of :rank, :on => :create
  
  private
  
  def check_rank
    self.rank = Seo::GooglePR.new(self.domain.url).page_rank
  rescue OpenURI::HTTPError
    self.rank = nil
  end
  
end