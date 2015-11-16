class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id, index: true
      t.string :title
      t.string :url
      t.text :description
      t.integer :votes_count, default: 0
      t.timestamps null: false
      t.string :slug, index: true
    end
  end
end