class BounEduEarthquakesJob
  include Sidekiq::Job
  # sidekiq_options queue: 'default'

  def perform(*args)
    earthquakes = BounEdu.get_earthquakes
    #<OpenStruct time=Tue, 26 Apr 2022 00:09:00 +0000, lat=39.2815, lng=26.9357, depth=6.0, type="ML", magnitude="1.9", location_desc="OKCULAR-BERGAMA (IZMIR)">]
    earthquakes.each do |e|
      Earthquake.near([e.lat, e.long], 5).where("time between ? and ?", e.time-15.seconds, e.time+15.seconds).count(:all)
      36.88366701,30.70150971
      36.88390389,30.67867395
    end
  end
end
