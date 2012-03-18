class CreatePageranks < ActiveRecord::Migration
  def change
    create_table :pageranks do |t|
      t.integer :rank
      t.integer :domain_id

      t.timestamps
    end
  end
end
