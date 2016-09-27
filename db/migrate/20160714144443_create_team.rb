class CreateTeam < ActiveRecord::Migration
  def up
    create_table :teams do |t|
      t.string :name
      t.string :short_code
      t.references :team, index: true

      t.boolean :active, default: true
      t.timestamps
    end
  end
  
  def down
    drop_table :teams
  end
end
