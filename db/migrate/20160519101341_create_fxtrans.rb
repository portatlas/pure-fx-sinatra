class CreateFxtrans < ActiveRecord::Migration
  def change
    create_table :fxtrans do |t|
      t.integer :requestor_id, :null => false
      t.integer :acceptor_id
      t.string :trantype
      t.integer :amount, :null => false
      t.integer :fxrate
      t.string :curr_buy, :null => false
      t.string :curr_sell, :null => false
      t.string :status, :null => false
      t.string :zipcode, :null => false

      t.timestamps :null => false
    end
  end
end
