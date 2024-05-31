// app/javascript/controllers/form_validation_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "address",
    "addressCountry",
    "addressCity",
    "addressZipCode",
    "screenNumber",
    "deskNumber",
    "bedNumber",
    "internetSpeed",
    "outdoor",
    "airConditionning",
    "pricePerDay",
    "photos",
    "submit",
  ];

  connect() {
    this.validateForm(); // Initial validation check to disable/enable the submit button
  }

  validateInput(event) {
    this.checkInput(event.target);
    this.validateForm();
  }

  validateForm() {
    let isValid = true;

    if (!this.checkInput(this.addressTarget)) isValid = false;
    if (!this.checkInput(this.addressCountryTarget)) isValid = false;
    if (!this.checkInput(this.addressCityTarget)) isValid = false;
    if (!this.checkInput(this.addressZipCodeTarget)) isValid = false;
    if (!this.checkInput(this.screenNumberTarget)) isValid = false;
    if (!this.checkInput(this.deskNumberTarget)) isValid = false;
    if (!this.checkInput(this.bedNumberTarget)) isValid = false;
    if (!this.checkInput(this.internetSpeedTarget)) isValid = false;
    if (!this.checkInput(this.pricePerDayTarget)) isValid = false;
    if (!this.checkInput(this.photosTarget)) isValid = false;

    this.submitTarget.disabled = !isValid;
  }

  checkInput(input) {
    if (!input) return false;

    if (input.type === "checkbox") {
      if (!input.checked) {
        this.showValidationError(input, "This field is required.");
        return false;
      }
    } else {
      if (input.value.trim() === "") {
        this.showValidationError(input, "This field is required.");
        return false;
      }
    }
    this.clearValidationError(input);
    return true;
  }

  showValidationError(input, message) {
    input.classList.add("invalid");
    let error = input.nextElementSibling;
    if (!error || !error.classList.contains("validation-error")) {
      error = document.createElement("div");
      error.classList.add("validation-error");
      input.insertAdjacentElement("afterend", error);
    }
    error.textContent = message;
  }

  clearValidationError(input) {
    input.classList.remove("invalid");
    let error = input.nextElementSibling;
    if (error && error.classList.contains("validation-error")) {
      error.remove();
    }
  }
}
