class CreatePageranks < ActiveRecord::Migration
  def self.up
    create_table :pageranks do |t|
      t.integer :rank
      t.integer :domain_id
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :pageranks
  end
end