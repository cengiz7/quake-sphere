import consumer from "channels/consumer"
import QuakeSphere from "quake_sphere"
import { application } from "../controllers/application";

var globe = new QuakeSphere([]);

window.globe = globe

console.log(document.getElementById("room").attributes.getNamedItem("data-room"))

const room = document.getElementById("room").attributes.getNamedItem("data-room").value

window.channel_consumer = consumer.subscriptions.create({channel: "EarthquakeChannel", room: room}, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to Earthquake channel.");
    this.perform("my_method", { msg: "new connection Cengiz" } ); 
    // channel.receive
    this.send({ msg: "new connection Cengiz" }); 
  },

  disconnected() {
    alert("Socket connection lost!")
  },

  received(data) {
    // TODO: filtreler aktifse yeni datayi renderlama
    // data action "filtered" ise renderla
    console.log(data)
    if(data.action === "automatic-feed"){
      console.info("Incoming  Automatic feed ")
    } else {
      globe.prepareQuakeData(data)
      globe.refreshQuakes()
    }
  },

  filter(props) {
    console.info("form props alindi", props)
  },

  sending(data) {
    console.log("sending",)
  }
});
