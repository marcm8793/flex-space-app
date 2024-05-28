import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="favorite"
export default class extends Controller {
  static targets = ["icon"];

  toggleFavorite(event) {
    event.preventDefault();
    const placeId = this.iconTarget.dataset.placeId;
    const isFavorite = this.iconTarget.style.color === "red";
    const method = isFavorite ? "DELETE" : "POST";
    const url = `/places/${placeId}/favorite`;

    fetch(url, {
      method: method,
      headers: {
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
        "Content-Type": "application/json",
      },
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.flash) {
          this.updateFlashContainer(data.flash);
        }
        this.iconTarget.style.color = isFavorite ? "grey" : "red";
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }

  updateFlashContainer(flashHtml) {
    const flashContainer = document.getElementById("flash-container");
    flashContainer.innerHTML = flashHtml;
  }
}
