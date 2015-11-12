class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id, index: true
      t.string :voteable_type, index: true
      t.integer :voteable_id, index: true
      t.timestamps null: false
    end
  end
end