require 'test_helper'

class PagerankTest < ActiveRecord::TestCase
  
  should_belong_to :domain
  
  
  context "on create" do
    setup do
      @domain = Domain.create(:url => "www.google.com")
      @rank = Pagerank.create(:domain => @domain)
    end
    
    should "request google" do
      assert @rank.rank
      assert_equal 10, @rank.rank
    end
  end
  
  context "false domain" do
    setup do
      @domain = Domain.create(:url => "asdfgasf.de")
      @pagerank = Pagerank.create(:domain => @domain)
    end
    should "raise RecordNotFound" do
      assert @pagerank.new_record?
      assert !@pagerank.save
    end
  end
end
