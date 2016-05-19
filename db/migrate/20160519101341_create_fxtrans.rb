class CreateFxtrans < ActiveRecord::Migration
  def change
    create_table :fxtrans do |t|
      t.integer :requestor_id, :null => false
      t.integer :acceptor_id
      t.string :type, :null => false
      t.integer :size, :null => false
      t.string :curr_buy, :null => false
      t.string :curr_sell, :null => false
      t.string :status, :null => false

      t.timestamps :null => false
    end
  end
end
