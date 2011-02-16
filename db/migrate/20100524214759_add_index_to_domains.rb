class AddIndexToDomains < ActiveRecord::Migration
  def self.up
    add_index :domains, :url, :unique => true
  end

  def self.down
    remove_index :domains, :url
  end
end
