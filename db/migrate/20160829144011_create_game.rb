class CreateGame < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.datetime :game_date
      t.string :season
      t.string :round
      t.references :local_team, index: true
      t.references :away_team, index: true

      t.boolean :active, default: true
      t.timestamps
    end
  end

  def down
    drop_table :games
  end
end
