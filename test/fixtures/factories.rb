Factory.define :domain do |d|
  d.url "hallo.de"
end
Factory.define :pagerank do |p|
  p.rank 6 
  p.domain { |a| a.association(:domain) }
end