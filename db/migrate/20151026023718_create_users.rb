class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, index: true
      t.string :password_digest
      t.string :email
      t.string :time_zone
      t.string :phone
      t.string :pin
      t.timestamps null: false
    end
  end
end