class CreatePlayer < ActiveRecord::Migration
  def up
    create_table :players do |t|
      t.string :name
      t.string :short_name
      t.string :position
      t.string :position_detail
      t.integer :height
      t.integer :weithg
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :nacionality
      t.string :image
      t.integer :price_cents
      t.string :href

      t.references :team, index: true

      t.boolean :active, default: true
      t.timestamps
    end
  end

  def down
    drop_table :players
  end
end
