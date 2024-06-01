import { Controller } from "@hotwired/stimulus";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String };
  static targets = [
    "address",
    "addressCountry",
    "addressCity",
    "addressZipCode",
  ];

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
    });

    this.geocoder.addTo(this.addressTarget.parentElement); // Add the geocoder to the parent element of the address input

    this.geocoder.on("result", (event) => this.setInputValue(event));
    this.geocoder.on("clear", () => this.clearInputValue());
  }

  setInputValue(event) {
    console.log("Geocoder result:", event.result);

    const address = event.result.place_name;
    this.addressTarget.value = address;

    const context = event.result.context;
    let postcode = "";
    let city = "";
    let country = "";

    context.forEach((item) => {
      if (item.id.includes("postcode")) {
        postcode = item.text;
      } else if (item.id.includes("place")) {
        city = item.text;
      } else if (item.id.includes("country")) {
        country = item.text;
      }
    });

    if (this.hasAddressCountryTarget) this.addressCountryTarget.value = country;
    if (this.hasAddressCityTarget) this.addressCityTarget.value = city;
    if (this.hasAddressZipCodeTarget)
      this.addressZipCodeTarget.value = postcode;
  }

  clearInputValue() {
    this.addressTarget.value = "";
    if (this.hasAddressCountryTarget) this.addressCountryTarget.value = "";
    if (this.hasAddressCityTarget) this.addressCityTarget.value = "";
    if (this.hasAddressZipCodeTarget) this.addressZipCodeTarget.value = "";
  }

  disconnect() {
    console.log("Disconnecting MapboxGeocoder...");
    this.geocoder.onRemove();
  }
}
