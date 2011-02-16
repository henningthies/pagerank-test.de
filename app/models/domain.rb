class Domain < ActiveRecord::Base
  
  after_save :check_rank
  before_validation_on_create :tune_url
  
  has_many :pageranks, :class_name => "Pagerank", :foreign_key => "domain_id", :dependent => :destroy
  named_scope :by_name, lambda{|p| {:conditions => ["url=?", p["url"] ], :limit => 1 } }
  validates_uniqueness_of :url, :on => :create, :message => "bereits vorhanden"
  
  def check_rank
    if self.pagerank.nil? || self.pagerank.updated_at.to_date < (Time.now - 2.hours).to_date
      Pagerank.create(:domain => self)
    end
  end
  
  def pagerank
    self.pageranks.last
  end
  
  def chart_ranks
    size = self.pageranks.size
    ranks = []
    puts size
    if self.pageranks.size > 4
      factor = self.pageranks.size / 5.0
      puts factor
      for c in 0..4
        i = (c * factor ).round
        puts i
        ranks << self.pageranks[i]
      end
      ranks << self.pageranks.last
    else
      ranks = self.pageranks
    end
    ranks
  end
  
  private
  def tune_url
    self.url.downcase!
    self.url.gsub!("http://","")
    self.url.gsub!("https://","")
    self.url.gsub!("www.","")
    self.url = self.url.split("/").first
  end
  
end