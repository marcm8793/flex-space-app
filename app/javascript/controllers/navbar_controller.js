import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["content", "icon"];

  connect() {
    window.addEventListener("scroll", this.toggleNavbarContent.bind(this));
  }

  disconnect() {
    window.removeEventListener("scroll", this.toggleNavbarContent.bind(this));
  }

  toggleNavbarContent() {
    if (window.scrollY > 50) {
      this.contentTarget.classList.add("d-none");
      this.iconTarget.classList.remove("d-none");
    } else {
      this.contentTarget.classList.remove("d-none");
      this.iconTarget.classList.add("d-none");
    }
  }
}
