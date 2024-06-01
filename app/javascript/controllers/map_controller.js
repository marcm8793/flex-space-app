import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl"; // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Array,
  };

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
    });
    this.#addMarkersToMap();
    this.#fitMapToMarkers();
  }

  #addMarkersToMap() {
    const popup = new mapboxgl.Popup().setHTML(
      this.markerValue[0].info_window_html
    );
    const customMarker = document.createElement("div");
    customMarker.innerHTML = this.markerValue[0].marker_html;
    new mapboxgl.Marker(customMarker)
      .setLngLat([this.markerValue[0].lng, this.markerValue[0].lat])
      .setPopup(popup)
      .addTo(this.map);
  }
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([this.markerValue[0].lng, this.markerValue[0].lat]);
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}
