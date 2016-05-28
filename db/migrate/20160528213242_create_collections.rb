class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
    	t.integer :album_id
    	t.integer :user_id

    	t.timestamps(null: false)
    end
  end
end
