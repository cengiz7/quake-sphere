# rake data_sources:seed_genres must be run before the seeds

Earthquake.destroy_all

# ANTALYA YAT LIMANI
center_latitude = 36.88429922
center_longtitude = 30.70221813

100.times do |i|
  Earthquake.create!([
    {
      lat: center_latitude + (i*0.01),
      long: center_longtitude + (i*0.01),
      depth: rand((0.5)..(150.0)),
      magnitude: rand((0.1)..(10.0)),
      magnitude_type: 'ML',
      time: Time.now - rand(0..604800).seconds,
      data_source_id: 1 # System
    },
    {
      lat: center_latitude - (i*0.01),
      long: center_longtitude - (i*0.01),
      depth: rand((0.5)..(150.0)),
      magnitude: rand((0.1)..(10.0)),
      magnitude_type: 'ML',
      time: Time.now - rand(0..604800).seconds,
      data_source_id: 1 # System
    }
  ])
end

1000.times do |i|
  Earthquake.create!(
    lat: rand((-90.0)..(90.0)),
    long: rand((-180.0)..(180.0)),
    depth: rand((0.5)..(150.0)),
    magnitude: rand((0.1)..(10.0)),
    magnitude_type: 'ML',
    time: Time.now - rand(0..604800).seconds,
    data_source_id: 1 # System
  )
end
