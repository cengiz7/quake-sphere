class BounEduEarthquakesJob
  include Sidekiq::Job
  # sidekiq_options queue: 'default'

  def perform(*args)
    data_source = DataSource.find_by(slug: 'boun_edu')
    earthquakes = BounEdu.get_earthquakes
    # <OpenStruct time=Tue, 26 Apr 2022 00:09:00 +0000, lat=39.2815, long=26.9357, 
    # depth=6.0, magnitude_type="ML", magnitude=1.9, location_desc="OKCULAR-BERGAMA (IZMIR)">]

    earthquakes.each do |e|
      Earthquake.create!(
        lat: e.lat, long: e.long, time: e.time,
        depth: e.depth, magnitude: e.magnitude,
        magnitude_type: e.magnitude_type,
        location_desc: e.location_desc,
        data_source_id: data_source.id
      )
    end
  end
end
