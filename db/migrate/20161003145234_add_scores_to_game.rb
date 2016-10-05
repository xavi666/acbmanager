class AddScoresToGame < ActiveRecord::Migration
  def change
    add_column :games, :local_score, :integer
    add_column :games, :away_score, :integer
  end
end
