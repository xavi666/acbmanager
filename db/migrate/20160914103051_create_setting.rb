class CreateSetting < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name
      t.string :key, index: true
      t.string :value, index: true

      t.timestamps null: false
    end
  end
end
