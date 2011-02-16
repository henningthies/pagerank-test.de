desc "import old ranks"
task :import => :environment do
  
  def tune_url(url)
    s = url
    s.downcase!
    s.gsub!("http://","")
    s.gsub!("https://","")
    s.gsub!("www.","")
    s = s.split("/").first
    s
  end
  
  f = File.open("#{RAILS_ROOT}/export.csv","r").read
  ranks = f.split("\n")
  count = 0
  ranks.each do |rank|
    count += 1
    rank = rank.split(",")
    domain = Domain.find_or_create_by_url(tune_url(rank[0]))
    Pagerank.create(:rank => rank[1].to_i,:domain_id => domain.id,:created_at => Time.parse(rank[2]))
  end
  puts count

end

desc "clean db after import url with less than 1 pagerank"
task :clean_db_after_import => :environment do
  domains = Domain.find(:all, :include => :pageranks)
  domains.each do |domain|
    if domain.pageranks.size < 2
      domain.destroy
    end
  end
  
end

desc "monthly cleanup"
task :monthly_cleanup => :environment do
  domains = Domain.find(:all, :include => :pageranks)
  domains.each do |domain|
    first_rank = domain.pageranks.first
    d_time = Time.now - first_rank.created_at
    puts "#{first_rank.created_at}, #{Time.now} = #{d_time}"
  end
end

desc "updated all ranks"
task :update_all_ranks => :environment do
  domains = Domain.find(:all, :include => :pageranks)
  domains.each do |domain|
    domain.check_rank
  end
end

desc "delete dublicate ranks"
task :delete_dub_ranks => :environment do
  domains = Domain.find(:all, :include => :pageranks)
  domains.each do |domain|
    old = nil
    domain.pageranks.each do |pagerank|
      
      if old.nil?
        old = pagerank
      else
        if old.updated_at.to_date == pagerank.updated_at.to_date
          pagerank.destroy
        else
          old = pagerank
        end
      end
    end
  end
end

desc "test time" 
task :show_time => :environment do
	puts Time.now
end