import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="bulk-data"
export default class extends Controller {
  static targets = [
    "bulkDataInput",
    "addressCountry",
    "addressCity",
    "addressStreetName",
    "addressZipCode",
    "screenNumber",
    "deskNumber",
    "bedNumber",
    "internetSpeed",
    "outdoor",
    "airConditionning",
    "pricePerDay",
  ];

  connect() {
    this.bulkDataInputTarget.addEventListener(
      "input",
      this.fillForm.bind(this)
    );
  }

  fillForm() {
    const data = this.bulkDataInputTarget.value.split(",");
    if (data.length >= 11) {
      this.addressCountryTarget.value = data[0].trim();
      this.addressCityTarget.value = data[1].trim();
      this.addressStreetNameTarget.value = data[2].trim();
      this.addressZipCodeTarget.value = data[3].trim();
      this.screenNumberTarget.value = data[4].trim();
      this.deskNumberTarget.value = data[5].trim();
      this.bedNumberTarget.value = data[6].trim();
      this.internetSpeedTarget.value = data[7].trim();
      this.outdoorTarget.checked = data[8].trim().toLowerCase() === "true";
      this.airConditionningTarget.checked =
        data[9].trim().toLowerCase() === "true";
      this.pricePerDayTarget.value = data[10].trim();
    }
  }
}
