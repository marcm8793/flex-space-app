import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="range"
export default class extends Controller {
  static targets = ["range", "output"];

  connect() {
    this.updateOutput();
  }

  updateOutput() {
    this.outputTargets.forEach((output, index) => {
      output.textContent = this.rangeTargets[index].value;
    });
  }

  handleInput(event) {
    const index = this.rangeTargets.indexOf(event.target);
    this.outputTargets[index].textContent = event.target.value;
  }
}
