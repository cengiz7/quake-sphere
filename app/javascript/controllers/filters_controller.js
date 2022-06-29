import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    this.roomID = document.getElementById("room").attributes.getNamedItem("data-room").value
  }
  connect() {
    console.log("Hello stimulus")
    console.warn(this.roomID)
  }

  static get targets() {
    return ["form"]
  }

  submit(event) {
    //this.formTarget.requestSubmit()
    event.preventDefault()
    event.stopPropagation()
  }

  handleSubmit(event) {
    const formData = new FormData(this.formTarget)
    const formProps = Object.fromEntries(formData)
    console.warn(["Form values", formProps])
    window.channel_consumer.filter(formProps)
  }
}
