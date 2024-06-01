import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="compute-price"
export default class extends Controller {
  static targets = [
    "firstDay",
    "lastDay",
    "priceElement",
    "totalDays",
    "totalPrice",
  ];
  static values = { fee: Number };

  compute() {
    const startDate = this.firstDayTarget.value;
    const endDate = this.lastDayTarget.value;

    console.log(startDate, endDate);

    let dateDiffInMilliseconds = new Date(endDate) - new Date(startDate);
    let nbrOfNights = dateDiffInMilliseconds / 86400000;

    if (startDate && endDate) {
      this.totalDaysTarget.innerText = nbrOfNights;
      this.totalPriceTarget.innerText = this.feeValue * nbrOfNights;
    }
  }
}
