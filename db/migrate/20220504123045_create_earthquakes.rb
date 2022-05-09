class CreateEarthquakes < ActiveRecord::Migration[7.0]
  def change
    create_table :earthquakes do |t|
      t.decimal :lat, precision: 9, scale: 7, null: false
      t.decimal :long, precision: 10, scale: 7, null: false
      t.decimal :depth, precision: 8, scale: 4
      t.decimal :magnitude, precision: 3, scale: 1, null: false
      t.string :magnitude_type, limit: 5
      t.datetime :time, null: false
      t.string :location_desc
      t.belongs_to :main, foreign_key: { to_table: :earthquakes }, null: true

      t.timestamps

      t.index %i[long lat]
      t.index :magnitude

    end
  end
end
