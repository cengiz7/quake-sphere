class AddDataSourceRefToEarthquakes < ActiveRecord::Migration[7.0]
  def change
    add_reference :earthquakes, :data_source, null: false, foreign_key: true
  end
end
