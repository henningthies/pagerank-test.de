class Domain < ActiveRecord::Base
  
  after_save :check_rank

  has_many :pageranks, :class_name => "Pagerank", :foreign_key => "domain_id", :dependent => :destroy
  validates_uniqueness_of :url, :on => :create, :message => "bereits vorhanden"
  
  before_validation(:on => :create) do
    self.url.downcase!
    self.url.gsub!("http://","")
    self.url.gsub!("https://","")
    self.url.gsub!("www.","")
    self.url = self.url.split("/").first
  end
  
  def check_rank
    if self.pagerank.nil? || self.pagerank.updated_at.to_date < (Time.now - 2.hours).to_date
      self.pageranks.create
    end
  end
  
  def pagerank
    self.pageranks.last
  end
  
  def chart_ranks
    size = self.pageranks.size
    ranks = []
    if self.pageranks.size > 4
      factor = self.pageranks.size / 5.0
      for c in 0..4
        i = (c * factor ).round
        ranks << self.pageranks[i]
      end
      ranks << self.pageranks.last
    else
      ranks = self.pageranks
    end
    ranks
  end
  
end
