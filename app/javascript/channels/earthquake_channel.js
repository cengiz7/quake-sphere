import consumer from "channels/consumer"

consumer.subscriptions.create("EarthquakeChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to Earthquake channel.");

    this.perform("my_method"); 

    // channel.receive
    this.send({ msg: "new connection" }); 
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data)
  },

  sending(data) {

  }
});