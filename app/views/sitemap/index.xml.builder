xml.instruct!
 
xml.urlset "xmlns" => "http://www.google.com/schemas/sitemap/0.84" do
  xml.url do
    xml.loc         "http://www.pagerank-test.de/"
    xml.lastmod     w3c_date(Time.now)
    xml.changefreq  "always"
  end
 
  @domains.each do |domain|
    xml.url do
      xml.loc         "http://www.pagerank-test.de/#{domain.url}"
      xml.lastmod     w3c_date(domain.updated_at)
      xml.changefreq  "daily"
      xml.priority    0.8
    end
  end
 
end