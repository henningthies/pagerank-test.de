require 'test_helper'

class DomainTest < ActiveRecord::TestCase
  

  should_have_many :pageranks
  
  context "find_by_name" do
    setup do
      @domain = Factory.create(:domain)
      
      params = {"tld"=>"de", "action"=>"detail", "domain"=>"hallo", "controller"=>"domain"}
      @search = Domain.by_name(params).first
    end
    
    should "find hallo.de" do
      assert_instance_of Domain, @search
      assert_equal "hallo.de", @search.url
    end
  end
  
  context "same name" do
    setup do
      @names= %w(http://www.henning-thies.de www.henning-thies.de http://henning-thies.de HENNING-THIES.de)
      @names.each do |name|
        domain = Domain.create(:url => name)
      end
    end
    
    should "not create new Domain" do
      assert_equal 2, Domain.all.size
    end
  end

  context "create domain" do
    setup do
      @domain = Domain.create(:url => "google.de")
    end
    
    should "have a pagerank" do
      assert_equal 1, @domain.pageranks.length
    end
    should "have a 8 pagerank" do
      assert_equal 8, @domain.pageranks.first.rank
    end
    
    should "update pagerank" do
      @domain.touch
      assert_equal 2,@domain.pageranks.length
    end
  end
  
  context "false input" do
    
    setup do 
      @inputs = %w(http://asdf.asdf http://a,de http:/google.de)
    end
    
    should "not requst" do
      @inputs.each do |input|
        @domain = Domain.create(:url => input)
        assert_equal -1, @domain.pageranks.first.rank
      end
    end
    
  end
  
  context "right input" do
    setup do 
      @inputs = %w(google.de müller.de http://aufwind.tumblr.com/)
    end
    
    should "not requst" do
      @inputs.each do |input|
        domain = Domain.create(:url => input)
        assert_not_equal -1, domain.pageranks.first.rank
      end
    end
  end
  
  
end
