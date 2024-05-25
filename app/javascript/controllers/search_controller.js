import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["searchForm", "searchInput", "closeIcon"];

  connect() {
    this.hideSearchForm();
    document.addEventListener("click", this.hideSearchForm.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.hideSearchForm.bind(this));
  }

  showSearchForm() {
    this.searchFormTarget.style.display = "flex";
    this.closeIconTarget.style.display = "block";
  }

  hideSearchForm(event) {
    if (
      event &&
      (this.element.contains(event.target) ||
        this.searchFormTarget.contains(event.target))
    ) {
      return;
    }
    if (this.searchInputTarget.value.trim() !== "") {
      return;
    }
    this.searchFormTarget.style.display = "none";
    this.closeIconTarget.style.display = "none";
  }

  stopPropagation(event) {
    event.stopPropagation();
  }

  resetForm(event) {
    event.stopPropagation();
    this.searchInputTarget.value = "";
    this.hideSearchForm();
  }
}
