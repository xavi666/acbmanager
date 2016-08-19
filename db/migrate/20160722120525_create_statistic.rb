class CreateStatistic < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.string :season
      t.jsonb :week_1, default: {}
      t.jsonb :week_2, default: {}
      t.jsonb :week_3, default: {}
      t.jsonb :week_4, default: {}
      t.jsonb :week_5, default: {}
      t.jsonb :week_6, default: {}
      t.jsonb :week_7, default: {}
      t.jsonb :week_8, default: {}
      t.jsonb :week_9, default: {}
      t.jsonb :week_10, default: {}
      t.jsonb :week_11, default: {}
      t.jsonb :week_12, default: {}
      t.jsonb :week_13, default: {}
      t.jsonb :week_14, default: {}
      t.jsonb :week_15, default: {}
      t.jsonb :week_16, default: {}
      t.jsonb :week_17, default: {}
      t.jsonb :week_18, default: {}
      t.jsonb :week_19, default: {}
      t.jsonb :week_20, default: {}
      t.jsonb :week_21, default: {}
      t.jsonb :week_22, default: {}
      t.jsonb :week_23, default: {}
      t.jsonb :week_24, default: {}
      t.jsonb :week_25, default: {}
      t.jsonb :week_26, default: {}
      t.jsonb :week_27, default: {}
      t.jsonb :week_28, default: {}
      t.jsonb :week_29, default: {}
      t.jsonb :week_30, default: {}
      t.jsonb :week_31, default: {}
      t.jsonb :week_32, default: {}
      t.jsonb :week_33, default: {}
      t.jsonb :week_34, default: {}
      t.jsonb :promedio, default: {}
      t.jsonb :total, default: {}

      t.references :player, index: true
    end
  end
end
