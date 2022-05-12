class EarthquakeChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'earthquake_channel'
  end

  def unsubscribed
    stop_all_streams
  end

  def receive(data)
    puts ["Gelen data: ", data]
  end

  def my_method(data)
    puts ["performdan gelen data: ", data]
  end
end
