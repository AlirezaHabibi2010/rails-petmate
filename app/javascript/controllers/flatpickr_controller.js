import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
// Import the rangePlugin from the flatpickr library
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ "startTime", "endTime" ]
  static values = {
    startTime: String,
    endTime: String,
  }
  connect() {
    const unvailableDates = JSON.parse(document.querySelector('.widget-content').dataset.unavailable)
    var today = new Date();
    var time = (today.getHours() + 1) + ":00";
    flatpickr(this.startTimeTarget, {
              "enableTime": true,

              minDate: 'today',
              minTime: time,
              time_24hr: true,
              // maxDate: new Date().fp_incr(7), // 14 days from now
              // dateFormat: "Y-m-d",
              dateFormat: "Y-m-d H:i",
              // defaultDate: ['today',  new Date().fp_incr(7)],
              disable: unvailableDates,
              // Provide an id for the plugin to work
              plugins: [new rangePlugin({ input: this.endTimeValue})],
            })
    flatpickr(this.endTimeTarget, {
              "enableTime": true,

              minDate: 'today',
              minTime: time,
              // maxDate: new Date().fp_incr(7), // 14 days from now
              // dateFormat: "Y-m-d",
              dateFormat: "Y-m-d H:i",
              // defaultDate: ["2024-10-11", "2024-10-10"],
              disable: unvailableDates,
              // Provide an id for the plugin to work
              plugins: [new rangePlugin({ input: this.startTimeValue})]
             })
  }
}
