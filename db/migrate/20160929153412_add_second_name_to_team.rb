class AddSecondNameToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :second_name, :string
  end
end
