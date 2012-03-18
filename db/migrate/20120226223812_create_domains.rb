class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :url

      t.timestamps
    end
    
    add_index :domains, :url
  end
end