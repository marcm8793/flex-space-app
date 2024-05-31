import { Controller } from "@hotwired/stimulus";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String };

  static targets = ["address"];

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
    });
    console.log(this.geocoder);
    this.geocoder.addTo(this.element);
    this.geocoder.on("result", (event) => this.#setInputValue(event));
    this.geocoder.on("clear", () => this.#clearInputValue());
  }

  #setInputValue(event) {
    console.log(event.result);
    const address = event.result.place_name;
    this.addressTarget.value = address;
  }

  #clearInputValue() {
    this.addressTarget.value = "";
  }

  disconnect() {
    this.geocoder.onRemove();
  }
}
