class EarthquakeChannel < ApplicationCable::Channel
  def subscribed
    # TODO validate room with enc cookie val
    # puts "Sub cookie", connection.find_visitor_token
    stream_from "earthquakeChannel_#{params[:room]}"
    initial_broadcast
  end

  def unsubscribed
    stop_all_streams
  end

  def receive(data)
    #puts ["Send Gelen data: ", data]
  end

  def my_method(data)
    #puts ["performdan gelen data: ", data]
  end

  private
  def initial_broadcast
    ActionCable.server.broadcast(
      "earthquakeChannel_#{params[:room]}",
      Earthquake.ordered
                .mains
                .last(ENV.fetch("SHOW_LAST_QUAKE_COUNT", 50).to_i)
                .map(&:serialize)
                .as_json
    )
  end
end
