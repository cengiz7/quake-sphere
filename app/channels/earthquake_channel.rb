class EarthquakeChannel < ApplicationCable::Channel
  def subscribed
    # TODO validate room with enc cookie val
    # puts "Sub cookie", connection.find_visitor_token
    stream_from "#{$quake_channel_name_prefix}:#{params[:room]}"
    initial_broadcast
  end

  def unsubscribed
    stop_all_streams
  end

  def receive(data)
    puts ["Send Gelen data: ", data]
  end

  def apply_filter(data)
    puts ["filtre verisi: ", data]
  end

  private

  # TODO: send it with sidekiq job
  def initial_broadcast
    ActionCable.server.broadcast(
      "#{$quake_channel_name_prefix}:#{params[:room]}",
      Earthquake.ordered
                .mains
                .last(ENV.fetch("SHOW_LAST_QUAKE_COUNT", 50).to_i)
                .map(&:serialize)
                .as_json
    )
  end
end
