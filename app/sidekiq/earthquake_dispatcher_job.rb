class EarthquakeDispatcherJob
  include Sidekiq::Job
  # sidekiq_options queue: 'default'

  def perform(*args)
    quakes = Earthquake.last_minute
                       .map(&:serialize)
                       .as_json

    open_channels = Redis.new.pubsub("channels", "action_cable/VISITOR*")

    open_channels.each do |sub|
      ActionCable.server.broadcast(
        generate_channel_name(sub),
        {action: "automatic-feed", data: quakes}
      )
    end
  end

  def generate_channel_name(sub)
    [
      $quake_channel_name_prefix,
      ':',
      sub.split('/').last
    ].join
  end
end
