class AddPriceToPlayer < ActiveRecord::Migration
  def change
    remove_column :players, :price_cents
    add_column :players, :price, :jsonb, default: {}  
  end
end
