import consumer from "channels/consumer"
import QuakeSphere from "quake_sphere"

var globe = new QuakeSphere([]);

window.globe = globe

console.log(document.getElementById("room").attributes.getNamedItem("data-room"))

const room = document.getElementById("room").attributes.getNamedItem("data-room").value

consumer.subscriptions.create({channel: "EarthquakeChannel", room: room}, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to Earthquake channel.");
    //this.perform("my_method"); 
    // channel.receive
    // this.send({ msg: "new connection" }); 
  },

  disconnected() {
    alert("Socket connection lost!")
  },

  received(data) {
    console.log(data)
    if(data.action === "automatic-feed"){
      console.info("Incoming  Automatic feed ")
    } else {
      globe.prepareQuakeData(data)
      globe.refreshQuakes()
    }
  },

  sending(data) {

  }
});
