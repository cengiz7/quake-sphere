class EarthquakeSerializer < ActiveModel::Serializer
  attributes :lat, :long, :depth, :magnitude, :magnitude_type, :time, :location_desc, :data_source_id

  has_many   :sub_records, class_name: 'Earthquake', foreign_key: 'main_id'
  # belongs_to :data_source

  def time
    object.time.utc.to_i
  end
end
