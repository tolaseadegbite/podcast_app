import { Controller } from "@hotwired/stimulus";
// import "shikwasa/dist/style.css";
import { Player } from "shikwasa";

// Connects to data-controller="podcast"
export default class extends Controller {
  connect() {
    console.log("Hello from Stimulus", this.element);

    const player = new Player({
      container: () => this.element,
      audio: {
        title: this.data.get("title"),
        artist: this.data.get("artist"),
        src: this.data.get("url"),
        cover: this.data.get("cover"),
      }
    });
  }
}
